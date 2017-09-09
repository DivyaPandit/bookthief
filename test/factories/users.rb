# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |f|
    name {Faker::Name.name}
    email {Faker::Internet.email}
    phone "9742218310"
  end
end
