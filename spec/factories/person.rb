FactoryGirl.define do

  factory :person do
    #association(:user)
    association :personable, factory: :user, strategy: :build
    last_name "Ivanov"
    first_name "Ivan"
    middle_name "Ivanovich"
    birthday "01.01.2000"
  end
end