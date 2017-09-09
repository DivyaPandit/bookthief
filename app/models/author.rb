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

  def self.search_authors(options)
  	@authors = Author.all
  	options = options.with_indifferent_access if options.present?
  	if options[:search_string].present?
  		
  	end
  	return @authors.to_json
  end	

end
