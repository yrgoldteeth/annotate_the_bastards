class AnnotationsController < ApplicationController
  respond_to :html
  before_filter :get_book
  before_filter :get_annotations
  before_filter :get_annotation, :only => [:show]
  before_filter :setup_pagination

  protected
  def setup_pagination
    unless @annotation
      @annotation = @annotations.first
    end

    unless params[:page] && params[:page].to_i == @annotation.pagination_page
      redirect_to book_annotation_path(@book, @annotation, :page => @annotation.pagination_page) and return
    end
  end

  def get_book
    @book = Book.find_by_slug(params[:book_id])
    unless @book
      flash[:error] = %Q(No book found with that id.  Choose one of #{Book.slug_list})
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
      redirect_to book_annotations_path(@book, :page => params[:page]) and return
    end
  end

  public
  def index;end
  def show;end
end
