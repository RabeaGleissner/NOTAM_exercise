require 'spec_helper'
describe Notice do
 it "has a valid factory" do  
  expect(FactoryGirl.build(:notice)).to be_valid
end
end