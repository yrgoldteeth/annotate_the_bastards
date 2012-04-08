class BooksController < ApplicationController
  respond_to :html
  before_filter :cache_that_shit


  def index
    @books = Book.all
  end

  def show
    @book = Book.find_by_slug(params[:id])
  end

end
