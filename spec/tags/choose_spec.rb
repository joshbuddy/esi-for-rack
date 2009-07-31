require 'spec/spec_helper'

describe "esi choose" do
  
 it "should pick the first available choice" do
   build_app('spec/tags/fixtures/choose/simple1.html', {}).last.should == ["\n    Hey you\n  "]
 end
 
 it "should pick next available choice" do
   build_app('spec/tags/fixtures/choose/simple2.html', {}).last.should == ["\n    And you\n  "]
 end
 
 it "should take the otherwise block if there is no valid choice" do
   build_app('spec/tags/fixtures/choose/simple3.html', {}).last.should == [" \n    No good\n  "]
 end

  
end