FactoryGirl.define do
  factory :author do |f|
  
   name {Faker::Book.unique.author}
   bio  {Faker::Lorem.paragraph(8)}

   academics {Faker::Educator.course}
   awards  "booker"

   before(:create) do |author,evaluator|
   	author.profile_pic = CarrierWave::Uploader::Download::RemoteFile.new(Faker::Avatar.image)
   end

   after(:create) do |author,evaluator|
   	5.times.each do |i|
	  FactoryGirl.create(:book,author:author)
	end  
   end
  end
end