class BooksController < ApplicationController
  respond_to :html, :json, :xml

  def index
    @books = Book.all
    respond_with { @books }
  end

end
