class BooksController < ApplicationController
  respond_to :html

  caches_page :index
  caches_page :show

  def index
    @books = Book.all
  end

  def show
    @book = Book.find_by_slug(params[:id])
  end

end
