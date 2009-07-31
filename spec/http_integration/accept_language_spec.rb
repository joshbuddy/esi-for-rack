require 'spec/spec_helper'

describe "esi user agent variable lookups" do
  
  it "should lookup a cookie variable" do
    
    vars = {'type' => 'user'}
    builder = Rack::Builder.new do
      use EsiForRack, {'/file/WIN' => 'os', '/file/1.5' => 'version', '/file/MOZILLA' => 'browser'}

      run proc { |env|
        data = IO.read('spec/http_integration/fixtures/accept_language/1.html')
        [200, {'Content-type' => 'text/html', 'Content-length' => data.size.to_s}, [data]]
      }
    end

    request = Rack::MockRequest.env_for("/?#{Rack::Utils.build_query(vars)}")
    request['HTTP_ACCEPT_LANGUAGE'] = 'da, en-gb;q=0.8, en;q=0.7'
    builder.call(request).last.should == ["<html><body>\nEN\nDA\nEN-GB\n\n</body></html>"]
    
  end
  
end