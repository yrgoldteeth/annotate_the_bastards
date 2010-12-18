class BooksController < ApplicationController
  respond_to :html, :json

  def index
    @books = Book.all
    respond_with @books
  end
    
end
