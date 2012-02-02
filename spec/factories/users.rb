# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	sequence :email do |n|
    "email#{n}@jambul.com"
  end

  factory :user do
  	first_name 'John'
    last_name  'Doe'
    email { Factory.next(:email) }
    password "foobar"
    password_confirmation {|u| u.password}
  end
end