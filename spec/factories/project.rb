FactoryGirl.define do

  factory :project do
    sequence(:name) { |i| "Test_Company_Name_#{i}" }
  end
end