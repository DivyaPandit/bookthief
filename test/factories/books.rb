FactoryGirl.define do
  factory :book do |f|
  	association :author , strategy: :build

  	name { Faker::Book.unique.title }
    short_description {Faker::Lorem.sentence(1)}
    long_description {Faker::Lorem.paragraph(1)}
    chapter_index [{page_number:1,chapter_name:"the boy who lived"},{page_number:2,chapter_name:"for greater good"},{page_number:3 , chapter_name:"albus dumbledore"}]  
    published_date {Faker::Date.between(2.years.ago, Date.today)}
    genre [GENRE.sample,GENRE.sample]

    before(:create) do |book,evaluator|
		book.genre = book.genre.uniq
    end

  	after(:create) do |book, evaluator|
  	 
  		# FactoryGirl.create(:review,book: book, reviewer: User.last)
      
  	end	
  end
end