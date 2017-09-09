# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do |f|
  	association :reviewer , strategy: :build
  	association :book , strategy: :build

  	rating {rand(1..5)}
  	title {["Great","Fascinating","Wastage of Time","Bore", "Classic","Good For children","Romantic"].sample}
    evaluation {[Faker::Lorem.sentence(2),"it is a mysterious book","Same concept like Harry Potter","Eragon at it's best"].sample}
  end
end
