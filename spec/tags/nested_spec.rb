require 'spec/spec_helper'

describe "esi nested" do
  
  it "nested1" do
    build_app('spec/tags/fixtures/nested/complex.html', {}).last.should == ["\n    BLAH!\n  "]
  end
  
  it "nested2" do
    build_app('spec/tags/fixtures/nested/complex.html', {'/include' => "<p>This is great</p>"}).last.should == ["\n    This is my include: <p>This is great</p>\n    Choice/true/Choice\n  "]
  end
  
end