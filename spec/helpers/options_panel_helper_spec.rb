require 'spec_helper'

describe YmCore::OptionsPanelHelper do
  
  describe "options_panel" do
    it "should return contents surrounded by div with class 'options_panel'" do
      options_panel("inline contents").should == "<div class=\"options_panel\">inline contents</div>"
    end
    it "should return contents of block surrounded by div with class 'options_panel'" do
      options_panel do
        "block contents"
      end.should == "<div class=\"options_panel\">block contents</div>"
    end
  end
  
end