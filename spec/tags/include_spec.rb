require 'spec/spec_helper'

describe "esi include" do
  
  it "should include a src" do
    build_app('spec/tags/fixtures/include/src.html', {'http://my-resource/' => "<p>This is great</p>"}).last.should == ["<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<html><body><p>This is great</p></body></html>\n"]
  end
  
  it "should include an alt if src is unavilable" do
    build_app('spec/tags/fixtures/include/alt.html', {'http://my-resource/' => "<p>This is great</p>"}).last.should == ["<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<html><body><p>This is great</p></body></html>\n"]
  end
  
  it "should raise an error if src is unavilable" do
    proc { build_app('spec/tags/fixtures/include/src.html', {}) }.should raise_error
  end
  
  it "should raise an error if src and alt is unavilable" do
    proc { build_app('spec/tags/fixtures/include/alt.html', {}) }.should raise_error
  end
  
  it "should continue though, if onerror=continue" do
    build_app('spec/tags/fixtures/include/src_continue.html', {}).last.should == ["<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<html><body></body></html>\n"]
  end
  
end