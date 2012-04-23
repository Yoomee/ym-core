require 'spec_helper'

describe YmCore::Model do
  
  describe "named_scope without" do
  
    before do
      FactoryGirl.create(:resource, :id => 1)
      FactoryGirl.create(:resource, :id => 2)
      FactoryGirl.create(:resource, :id => 3)
    end
  
    it "returns all resources when passed nil" do
      Resource.without(nil).collect(&:id).should include(1,2,3)
    end
    
    it "doesn't return resource it is passed" do
      resource_ids = Resource.without(Resource.find(1)).collect(&:id)
      resource_ids.sort.should == [2,3]
    end
    
    it "doesn't return resource it is passed the id of" do
      resource_ids = Resource.without(1).collect(&:id)
      resource_ids.sort.should == [2,3]
    end
    
    it "doesn't return resources in the array it is passed" do
      resource_ids = Resource.without(Resource.where('id < 3')).collect(&:id)
      resource_ids.sort.should == [3]
    end
    
    it "doesn't return resources with ids in the array it is passed" do
      resource_ids = Resource.without(Resource.where('id < 3')).collect(&:id)
      resource_ids.sort.should == [3]
    end
  
  end
  
end