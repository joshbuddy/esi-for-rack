require 'spec/spec_helper'

describe "esi user agent variable lookups" do
  
  it "should lookup a user agent variable" do
    
    vars = {'type' => 'user'}
    builder = Rack::Builder.new do
      use EsiForRack, {'/file/WIN' => 'os', '/file/1.5' => 'version', '/file/MOZILLA' => 'browser'}
      
      run proc { |env|
        data = IO.read('spec/http_integration/fixtures/user_agent/1.html')
        [200, {'Content-type' => 'text/html', 'Content-length' => data.size.to_s}, [data]]
      }
    end

    request = Rack::MockRequest.env_for("/?#{Rack::Utils.build_query(vars)}")
    request['HTTP_USER_AGENT'] = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0) Gecko/20060308 Firefox/1.5.0'
    builder.call(request).last.should == ["<html><body>\n  browser\n  os\n  version\n</body></html>"]
    
  end
  
end