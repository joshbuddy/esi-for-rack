require 'net/http'
require 'uri'

class EsiForRack

  class Lookup
    
    class Http
      
      class RedirectFollower
        class TooManyRedirects < StandardError; end

        attr_accessor :url, :body, :redirect_limit, :response, :code

        def initialize(url, limit=5)
          @url, @redirect_limit = url, limit
          logger.level = Logger::INFO
        end

        def logger
          @logger ||= Logger.new(STDOUT)
        end

        def resolve
          raise TooManyRedirects if redirect_limit < 0

          self.response = Net::HTTP.get_response(URI.parse(url))

          logger.info "redirect limit: #{redirect_limit}" 
          logger.info "response code: #{response.code}" 
          logger.debug "response body: #{response.body}" 

          if response.kind_of?(Net::HTTPRedirection)      
            self.url = redirect_url
            self.redirect_limit -= 1

            logger.info "redirect found, headed to #{url}" 
            resolve
          end

          self.body = response.body
          self.code = response.code
          self
        end

        def redirect_url
          if response['location'].nil?
            response.body.match(/<a href=\"([^>]+)\">/i)[1]
          else
            response['location']
          end
        end
      end


      def initialize(app, env)
        @app = app
        @env = env
      end
      
      def [](path)
        res = RedirectFollower.new(path).resolve
        res.body if res.code == '200'
      end
      
    end
    
    class PassThrough
      
      def initialize(app, env)
        @app = app
        @env = env
      end
      
      def [](path)
        return if path[0,4] == 'http'
        
        uri = URI(path)
        
        request = {
          "REQUEST_METHOD" => "GET",
          "SERVER_NAME" => @env['SERVER_NAME'],
          "SERVER_PORT" => @env['SERVER_PORT'],
          "QUERY_STRING" => uri.query.to_s,
          "PATH_INFO" => (!uri.path || uri.path.empty?) ? "/" : uri.path,
          "rack.url_scheme" => uri.scheme || @env['rack.url_scheme'] || 'http',
          "SCRIPT_NAME" => ""
        }

        response = @app.call(request)
        if response.first == 200
          EsiForRack.response_body_to_str(response.last)
        else
          nil
        end
      
      rescue URI::InvalidURIError
        nil
      end
      
    end
  
  end
end