FactoryGirl.define do

  factory :user do
    #association(:project)
    sequence(:email) { |i| "Email#{i}@Test.com" }
    password "foobar"
    password_confirmation "foobar"

    after(:build) do |user|
      user.person = build(:person, personable: user)
    end

    after(:create) do |user|
      user.person.save!
    end
  end
end