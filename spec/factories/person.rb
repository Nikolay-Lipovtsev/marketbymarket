FactoryGirl.define do

  factory :person do
    association :personable, factory: :user
    last_name "Ivanov"
    first_name "Ivan"
    middle_name "Ivanovich"
    birthday 20.years.ago
    sex "M"
  end
end