require 'spec/spec_helper'

describe "esi vars" do
  
  it "should render the content within vars" do
    build_app('spec/tags/fixtures/vars/simple.html', {}).last.should == ["<img src=\"http://www.example.com/b/hello.gif\"/ >"]
  end
  
end