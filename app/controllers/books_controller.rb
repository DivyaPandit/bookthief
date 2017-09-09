class BooksController < ApplicationController
	before_action :authenticate_user!

	def index
	  if params[:search].present? && params[:search][:search_string].present?
	  	search_string = params[:search][:search_string]
	  	books_json = Book.search_books({search_string: search_string})
	  	authors_json = Author.search_authors({search_string: search_string})
	  	reviews_json = Review.search_reviews({search_string: search_string})
	  end
	  respond_to do |format|
		format.json {render json: { books:books_json, authors: JSON.parse(authors_json), reviews_json: JSON.parse(reviews_json) }}
	  end
	end	
end
