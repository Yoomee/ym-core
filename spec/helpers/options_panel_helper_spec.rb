require 'spec_helper'

describe YmCore::OptionsPanelHelper do
  
  describe "options_panel" do
    it "should return contents surrounded by div with class 'options_panel mt-2'" do
      options_panel("inline contents").should == "<div class=\"options_panel mt-2\">inline contents</div>"
    end
    it "should return contents of block surrounded by div with class 'options_panel mt-2'" do
      options_panel do
        "block contents"
      end.should == "<div class=\"options_panel mt-2\">block contents</div>"
    end
  end
  
end