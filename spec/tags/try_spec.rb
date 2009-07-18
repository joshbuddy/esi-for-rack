require 'spec/spec_helper'

describe "esi try" do
  
  it "should raise on try block without except" do
    proc {
      build_app('spec/tags/fixtures/try/malformed_attempt.html', {'http://my-resource/' => "<p>This is great</p>"})
    }.should raise_error
  end
  
  it "should raise on try block without attempt" do
    proc {
      build_app('spec/tags/fixtures/try/malformed_attempt.html', {'http://my-resource/' => "<p>This is great</p>"})
    }.should raise_error
  end
  
  it "should include normally within an attempt block" do
    build_app('spec/tags/fixtures/try/include.html', {'http://my-resource/' => "<p>This is great</p>"}).last.should == 
      ["<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<html><body><p>This is great</p></body></html>\n"]
  end
  
  it "should render the except block when the include fails within an attempt block" do
    build_app('spec/tags/fixtures/try/include.html', {}).last.should == 
      ["<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<html><body>This is bad</body></html>\n"]
  end
  
  
end