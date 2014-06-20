FactoryGirl.define do

  factory :user do
    #association(:project)
    sequence(:email) { |i| "Email#{i}@Test.com" }
    password "foobar"
    password_confirmation "foobar"

    #after(:create) {|user| user.person = [create(:person)]}
    #user.after_create {|usr| Factory(:person, personable: usr)}
  end
end