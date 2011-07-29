class AnnotationsController < ApplicationController
  respond_to :html, :mobile
  before_filter :get_book
  
  protected
  def get_book
    @book = Book.find_by_slug(params[:book_id])
    unless @book
      flash[:error] = %Q(No book found with that id.  Choose one of #{Book.slug_list})
      redirect_to books_path and return
    end
  end
  
  public
  def index
    @annotations = @book.annotations.ordered
    unless mobile_device?
      @annotations = @annotations.paginate :page => params[:p]
    end
  end
  
  def show
    @annotation = @book.annotations.find_by_id(params[:id])
    unless @annotation
      flash[:error] = %(No annotation found with that id.)
      redirect_to book_annotations_path(@book)
    end
  end

  def page
    annotation = @book.annotations.start_page(params[:page_id].to_i).first
    unless annotation
      flash[:error] = %(No annotations found near that page number.)
      redirect_to book_annotations_path(@book) and return
    end

    unless annotation.page_number.to_s == params[:page_id]
      flash[:notice] = %Q(No annotations found for page #{params[:page_id]}.  Redirected to next page with annotations.)
      redirect_to annotation.page_number_link and return
    end
    @annotations = @book.annotations.for_page(annotation.page_number)
  end

end
