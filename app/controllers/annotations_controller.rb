class AnnotationsController < ApplicationController
  respond_to :json, :xml
  before_filter :get_book

  protected
  def get_book
    @book = Book.find_by_slug(params[:book_id])
    unless @book
      response = {:error => %Q(No book found with that id.  Choose one of #{Book.all.map(&:slug)})}
      respond_with response and return
    end
  end

  public
  #TODO filtering, dawg.
  def index
    response = []
    @book.annotations.index_format.each do |annotation|
      response << AnnotationResponse.index_response(annotation, book_annotation_url(@book, annotation))
    end
    respond_with response
  end

  def show
    annotation      = @book.annotations.show_format.find(params[:id])
    urls            = {}
    urls[:previous] = book_annotation_url(@book, annotation.previous_annotation)
    urls[:next]     = book_annotation_url(@book, annotation.next_annotation)
    response        = AnnotationResponse.show_response(annotation, urls)
    respond_with response
  end

end
