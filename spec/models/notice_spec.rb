require 'spec_helper'

  describe Notice do

   it "has a valid factory" do  
    expect(FactoryGirl.build(:notice)).to be_valid
  end

  describe ".new" do
    it 'creates a Notice object' do
      FactoryGirl.create(:notice)
      notice = FactoryGirl.build(:notice)
      expect(notice).to_not eq nil
    end
end

  it "extracts ICAO code" do
    input_array = ["some text here", "A) ESSV", "B) some more text"]
    notice = FactoryGirl.build(:notice)
    expect(notice.extract_icao_code(input_array)).to eq 'ESSV'
  end

  it "creates a new array from each element in an array" do
    input_array = ["some text here", "A) ESSV", "B) some more text"]
    notice = FactoryGirl.build(:notice)
    expect(notice.split_array(input_array)).to eq [["some", "text", "here"], ["A)", "ESSV"], ["B)", "some", "more", "text"]]
  end

  it "changes instance variables to variables for the model" do
    day = :tue
    start_day = @mon
    notice = FactoryGirl.build(:notice)
    expect(notice.set_variables(day, start_day)).to eq @tue
  end


end