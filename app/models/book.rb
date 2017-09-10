class Book
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  belongs_to :author
  has_many :reviews

  field :name, type: String
  field :short_description, type: String
  field :long_description, type:String
  field :chapter_index, type:Array , default: [] #array of hashes ex. [{page_number:1,chapter_name:"the boy who lived"},{},{} ,...]
  field :published_date, type: Date
  field :genre , type: Array 
  field :author_name, type: String

  validates :name , uniqueness: true
  validates :name,:short_description, :published_date, :genre , :author_id,  presence: true

   # index for full text search in below field
  index({ name: "text", short_description:"text", long_description:"text",genre:"text" })

  # saving author name in callback to avoid selector to author table
  before_save do |book|
    book.author_name = book.author.name
  end

   # Method Purpose : To search books
   # parameter : Hash with different field name along with search_string
   # return value : Filtered books.If not any, it will return all books
  def self.search_books(options)
    @books = Book.all.only(:name,:short_description,:genre,:id)
    options = options.with_indifferent_access if options.present?
    if options[:search_string].present?
     @books = Book.where({ :$text => { :$search => options[:search_string] } }).only(:name,:short_description,:genre,:id,:author_name)
    end
    return @books
  end
end
