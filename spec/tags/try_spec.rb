require 'spec/spec_helper'

describe "esi try" do
  
  it "should raise on try block without except" do
    proc {
      build_app('spec/tags/fixtures/try/malformed_attempt.html', {'/great' => "<p>This is great</p>"})
    }.should raise_error
  end
  
  it "should raise on try block without attempt" do
    proc {
      build_app('spec/tags/fixtures/try/malformed_attempt.html', {'/great' => "<p>This is great</p>"})
    }.should raise_error
  end
  
  it "should include normally within an attempt block" do
    build_app('spec/tags/fixtures/try/include.html', {'/great' => "<p>This is great</p>"}).last.should == 
      ["\n    <p>This is great</p>\n  \n"]
  end
  
  it "should render the except block when the include fails within an attempt block" do
    build_app('spec/tags/fixtures/try/include.html', {}).last.should == 
      ["This is bad\n"]
  end
  
  
end