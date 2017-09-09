class Book
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  belongs_to :author
  has_many :reviews

  field :name, type: String
  field :short_description, type: String
  field :long_description, type:String
  field :chapter_index, type:Array  #array of hashes ex. [{page_number:1,chapter_name:"the boy who lived"},{},{} ,...]  
  field :published_date, type: Date
  field :genre , type: Array 

  validates_associated :author
  validates :name , uniqueness: true
  validates :name,:short_description, :published_date, :genre , presence: true

  def self.search_books(options)
    @books = Book.all
    options = options.with_indifferent_access if options.present?
    if options[:search_string].present?
     
    end
    return @books.as_json
  end

end
