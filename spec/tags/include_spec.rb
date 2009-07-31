require 'spec/spec_helper'

describe "esi include" do
  
  it "should include a src" do
    build_app('spec/tags/fixtures/include/src.html', {'/great' => "<p>This is great</p>"}).last.should == ["<html><body>\n<p>This is great</p>\n</body></html>"]
  end
  
  it "should include an alt if src is unavilable" do
    build_app('spec/tags/fixtures/include/alt.html', {'/alternate' => "<p>This is great</p>"}).last.should == ["<html><body>\n<p>This is great</p>\n</body></html>"]
  end
  
  it "should raise an error if src is unavilable" do
    proc { build_app('spec/tags/fixtures/include/src.html', {}) }.should raise_error
  end
  
  it "should raise an error if src and alt is unavilable" do
    proc { build_app('spec/tags/fixtures/include/alt.html', {}) }.should raise_error
  end
  
  it "should continue though, if onerror=continue" do
    build_app('spec/tags/fixtures/include/src_continue.html', {}).last.should == ["<html><body>\n\n</body></html>"]
  end
  
end