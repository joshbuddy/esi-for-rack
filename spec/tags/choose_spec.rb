require 'spec/spec_helper'

describe "esi choose" do
  
 it "should pick the first available choice" do
   build_app('spec/tags/fixtures/choose/simple1.html', {}).last.should == ["<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<html><body>\n    Hey you\n  </body></html>\n"]
 end
 
 it "should pick next available choice" do
   build_app('spec/tags/fixtures/choose/simple2.html', {}).last.should == ["<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<html><body>\n    And you\n  </body></html>\n"]
 end
 
 it "should take the otherwise block if there is no valid choice" do
   build_app('spec/tags/fixtures/choose/simple3.html', {}).last.should == ["<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<html><body> \n    No good\n  </body></html>\n"]
 end

  
end