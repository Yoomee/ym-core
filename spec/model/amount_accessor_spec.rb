require 'spec_helper'

describe YmCore::Model::AmountAccessor do
  
  describe "amount_accessor" do
  
    before do
      Resource.amount_accessor(:amount)
      @resource = Resource.new
    end
  
    it "creates an amount setter method that updates amount_in_pence" do
      @resource.amount = 10
      @resource.amount_in_pence.should == 1000
    end
    
    it "creates an amount getter method that returns amount in pounds" do
      @resource.amount_in_pence = 2000
      @resource.amount.should == 20
    end
    
    it "getter method returns float with a to_s that returns 2 decimal places" do
      @resource.amount = 15
      @resource.amount.to_s.should == "15.00"
    end
    
    it "creates _before_type_cast getter method" do
      @resource.amount = "notanumber"
      @resource.amount_before_type_cast.should == "notanumber"
    end
    
    it "returns nil if amount is set to ''" do
      @resource.amount = ""
      [@resource.amount, @resource.amount_before_type_cast].should == [nil, nil]
    end
  
  end
  
end