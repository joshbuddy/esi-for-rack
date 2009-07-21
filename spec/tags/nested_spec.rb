require 'spec/spec_helper'

describe "esi nested" do
  
  it "nested1" do
    build_app('spec/tags/fixtures/nested/complex.html', {}).last.should == ["<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<html><body>\n    BLAH!\n  </body></html>\n"]
  end
  
  it "nested2" do
    build_app('spec/tags/fixtures/nested/complex.html', {'/include' => "<p>This is great</p>"}).last.should == ["<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<html><body>\n    This is my include: <p>This is great</p>\n    Choice/true/Choice\n  </body></html>\n"]
  end
  
end