require 'rack'
require 'lib/esi_for_rack'

def build_app(file, lookup)
  builder = Rack::Builder.new do
    use EsiForRack
    
    run proc { |env|
      data = if env['PATH_INFO'] == '/'
        IO.read(file)
      else
        lookup[env['PATH_INFO']]
      end
      
      if data 
        [200, {'Content-type' => 'text/html', 'Content-length' => data.size.to_s}, [data]]
      else
        [404, {}, []]
      end
    }
  end
  
  request = Rack::MockRequest.env_for("/?a=b")
  builder.call(request)
end