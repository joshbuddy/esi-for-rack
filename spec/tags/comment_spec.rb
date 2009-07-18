require 'spec/spec_helper'

describe "esi comment" do
  
  it "should not render a comment" do
    build_app('spec/tags/fixtures/comment/simple.html', {}).last.should == ["<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<html><body><p>This will show up.</p></body></html>\n"]
  end
  
end