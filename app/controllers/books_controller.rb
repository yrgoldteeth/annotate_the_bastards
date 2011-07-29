class BooksController < ApplicationController
  respond_to :html, :mobile

  def index
    @books = Book.all
  end

end
