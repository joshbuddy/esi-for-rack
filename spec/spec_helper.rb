I_KNOW_I_AM_USING_AN_OLD_AND_BUGGY_VERSION_OF_LIBXML2 = true

require 'rack'
require 'lib/esi_for_rack'

def build_app(file, lookup)
  builder = Rack::Builder.new do
    use EsiForRack, lookup
    
    run proc { |env|
      data = IO.read(file)
      [200, {'Content-type' => 'text/html', 'Content-length' => data.size.to_s}, [data]]
    }
  end
  
  request = Rack::MockRequest.env_for("/?a=b")
  builder.call(request)
end