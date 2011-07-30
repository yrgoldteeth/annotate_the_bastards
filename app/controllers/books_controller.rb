class BooksController < ApplicationController
  respond_to :html

  def index
    @books = Book.all
  end

end
