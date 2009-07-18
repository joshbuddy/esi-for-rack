require 'spec/spec_helper'

describe "esi vars" do
  
  it "should render the content within vars" do
    build_app('spec/tags/fixtures/vars/simple.html', {}).last.should == ["<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<html><body><img src=\"http://www.example.com/b/hello.gif\"></body></html>\n"]
  end
  
end