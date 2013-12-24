FactoryGirl.define do

  factory :user do
    association(:project)
    sequence(:email) { |i| "Email#{i}@Test.com" }
    password "foobar"
    password_confirmation "foobar"
  end
end