class Author
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  has_many :books

  field :name , type: String
  field :bio, type: String
  field :academics, type: String
  field :awards, type: String

  mount_uploader :profile_pic ,ImageUploader

  validates :name , presence: true , uniqueness: true

   # index for full text search in below field
  index({name:"text", bio:"text"})

   # Method Purpose : To search authors 
   # parameter : Hash with different field name along with search_string
   # return value : Filtered authors.If not any, it will return all authors
  def self.search_authors(options)
    @authors = Author.all.only(:id, :academics, :name, :profile_pic)
    options = options.with_indifferent_access if options.present?
  	if options[:search_string].present?
      @authors = Author.where({ :$text => { :$search => options[:search_string] } }).only(:id, :academics, :name, :profile_pic)
  	end
    return @authors
  end
end
