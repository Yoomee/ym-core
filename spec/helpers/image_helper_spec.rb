require 'spec_helper'

describe YmCore::ImageHelper do
  
  describe "width_height_from_geo_string" do
    
    it "returns [100, 110] if given '100x110'" do
      width_height_from_geo_string("100x110").should == [100,110]
    end
    
    it "returns [100, 110] if given '100x110#'" do
      width_height_from_geo_string("100x110#").should == [100,110]      
    end
    
    it "returns [100, nil] if given '100x'" do
      width_height_from_geo_string("100x").should == [100,nil]      
    end
    
  end
  
end