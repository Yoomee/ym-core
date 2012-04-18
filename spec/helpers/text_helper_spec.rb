require 'spec_helper'

describe YmCore::TextHelper do
  
  describe "summarize" do
    
    before do
      @resource = FactoryGirl.build(:resource)
    end
    
    describe "resource does respond_to summary" do
    
      before do
        @resource.stub(:summary => "1234\n5678")
      end
    
      it "returns simple_formatted summary" do
        summarize(@resource).should == simple_format("1234\n5678")
      end
    
      it "returns truncated summary if length option is passed" do
        summarize(@resource, :length => 4).should == simple_format(truncate("1234\n5678", :length => 4))
      end
    
    end
    
    describe "resource does respond_to text" do
      
      before do
        @resource.text = "<p><h1>1234</h1></br>567</p><p>89</p>"
      end
      
      it "returns sanitized text" do
        summarize(@resource).should == sanitize("<p><h1>1234</h1></br>567</p><p>89</p>", :tags => %w{p br})
      end
      
      it "returns truncated sanitized text if length option is passed" do
        
      end
      
    end

    describe "resource summary and text are blank" do
      
      before do
        @resource.stub(:summary => nil)
        @resource.stub(:text => nil)
      end
      
      it "returns resource to_s" do
        summarize(@resource).should == @resource.to_s
      end
      
    end

  end
  
end