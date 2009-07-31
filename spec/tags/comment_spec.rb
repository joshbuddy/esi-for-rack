require 'spec/spec_helper'

describe "esi comment" do
  
  it "should not render a comment" do
    build_app('spec/tags/fixtures/comment/simple.html', {}).last.should == ["This will show up."]
  end
  
end