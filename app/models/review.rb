class Review
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  belongs_to :reviewer , class_name: "User"
  belongs_to :book

  field :rating , type: Integer #rating of book
  field :title, type: String
  field :evaluation, type: String #judgement related to book

  validates :rating , :numericality => {in: 1..5}
  validates_associated :book
  validates_associated :reviewer

  def self.search_reviews(options)
    @reviews = Review.all
    options = options.with_indifferent_access if options.present?
    if options[:search_string].present?
  
    end
    return @reviews.to_json
  end
end
