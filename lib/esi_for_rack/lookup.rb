class EsiForRack

  class Lookup
    
    class PassThrough < Lookup
      
      def initialize(app, env)
        @app = app
        @env = env
      end
      
      def [](path)
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
          response_body = response.last
          if response_body.respond_to? :to_str
            response_body.to_str
          elsif response_body.respond_to?(:each)
            body = ''
            response_body.each { |part|
              body << part.to_s
            }
            body
          else
            raise TypeError, "stringable or iterable required"
          end
        else
          nil
        end
      
      rescue URI::InvalidURIError
        nil
      end
      
    end
  
  end
end