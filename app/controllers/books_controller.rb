class BooksController < ApplicationController
  respond_to :html, :json, :xml

  def index
    @books = Book.all
    respond_with @books
  end

  def show
    @book = Book.find_by_slug(params[:id])
    if @book
      redirect_to book_annotations_path(@book)
    else
      flash[:error] = %Q(No book found with that id.  Choose one of: #{Book.all.map(&:slug).join(', ')})
      redirect_to books_path
    end
  end

end
