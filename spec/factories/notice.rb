FactoryGirl.define do
  factory :notice do
    icao_code { :"EJGT" }
    mon { :"12:00-18:30" }
    tue { :"1:00-13:00"}
    wed {:"12:00-18:30"}
    thu {:"12:00-18:30"}
    fri {:"12:00-18:30"}
    sat {:"12:00-18:30"}
    sun {:"12:00-18:30"}
  end

end
