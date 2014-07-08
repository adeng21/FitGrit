# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "Tom"
    last_name "Sawyer"
    sequence(:email) {|n| "test#{n}@test.com"}
    password "password123"
  end
end
