require 'net/http'
require 'uri'

class EsiForRack

  class Lookup
    
    class Http
      
      def initialize(app, env)
        @app = app
        @env = env
      end
      
      def [](path)
        return unless path[0,4] == 'http'
        uri = URI(path)
        res = Net::HTTP.start(uri.host, uri.port) {|http|
          http.get(uri.request_uri)
        }
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