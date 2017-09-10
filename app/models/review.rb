class Review
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  belongs_to :reviewer , class_name: "User"
  belongs_to :book

  field :rating , type: Integer #rating of book
  field :title, type: String
  field :evaluation, type: String #judgement related to book
  field :reviewer_name , type: String

  validates :rating , :numericality => {in: 1..5}
  validates :book, :reviewer , presence: true

  # index for full text search in below field
  index({title:"text",evaluation:"text"})

  # saving reviewer name in callback to avoid selector to reviewer table
  before_save do |review|
    review.reviewer_name = review.reviewer.name
  end

 # Method Purpose : To search reviews
 # parameter : Hash with different field name along with search_string
 # return value : Filtered reviews.If not any, it will return all reviews
  def self.search_reviews(options)
    @reviews = Review.all.only(:id,:rating,:title,:evaluation)
    options = options.with_indifferent_access if options.present?
    if options[:search_string].present?
      @reviews = Review.where({ :$text => { :$search => options[:search_string] } }).only(:id,:rating,:title,:evaluation,:reviewer_name)
    end
    return @reviews
  end
end
