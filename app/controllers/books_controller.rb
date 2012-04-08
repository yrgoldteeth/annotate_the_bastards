class BooksController < ApplicationController
  respond_to :html
  before_filter :cache_that_shit

  caches_action :index
  caches_action :show


  def index
    @books = Book.all
  end

  def show
    @book = Book.find_by_slug(params[:id])
  end

end
