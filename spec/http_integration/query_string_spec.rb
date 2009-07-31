require 'spec/spec_helper'

describe "esi query string variable lookups" do
  
  it "should lookup a query string variable" do
    
    vars = {'id' => '1'}
    builder = Rack::Builder.new do
      use EsiForRack, {'/file/1' => 'resource'}

      run proc { |env|
        data = IO.read('spec/http_integration/fixtures/query_string/1.html')
        [200, {'Content-type' => 'text/html', 'Content-length' => data.size.to_s}, [data]]
      }
    end

    request = Rack::MockRequest.env_for("/?#{Rack::Utils.build_query(vars)}")
    builder.call(request).last.should == ["<html><body>\nresource\n</body></html>"]
    
  end
  
end