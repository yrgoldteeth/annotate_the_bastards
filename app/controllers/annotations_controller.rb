class AnnotationsController < ApplicationController
  respond_to :html, :json, :xml
  before_filter :get_book
  before_filter :get_annotations
  before_filter :get_annotation, :only => [:show]

  protected
  def get_book
    @book = Book.find_by_slug(params[:book_id])
    unless @book
      flash[:error] = %Q(No book found with that id.  Choose one of #{Book.all.map(&:slug).join(', ')})
      redirect_to books_path and return
    end
  end

  def get_annotations
    @annotations = @book.annotations.ordered.paginate :page => params[:page]
  end

  def get_annotation
    @annotation = @book.annotations.find_by_id(params[:id])
    unless @annotation
      flash[:error] = %(No annotation found with that id.)
      redirect_to book_annotations_path(@book) and return
    end
  end

  public
  def index
    respond_with @annotations
  end

  def show
    respond_with @annotation
  end

end
