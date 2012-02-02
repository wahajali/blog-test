# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    sequence(:title){|n| "MyString#{n}"}
    content "MyText"
    association :user
  end
end
