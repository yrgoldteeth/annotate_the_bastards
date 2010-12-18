class BooksController < ApplicationController
  respond_to :json, :xml

  def index
    books    = Book.result_set
    response = []
    books.each do |book|
      response << BookResponse.build(book, book_annotations_url(book))
    end
    respond_with response
  end

end
#    if params[:after].present? && @book.annotations.where("annotations.id = ?", params[:after]).any?
#      @annotations = @book.annotations.after(Annotation.find(params[:after])).result_set
#    elsif params[:after].blank? && params[:start_page].present?
#      @annotations = @book.annotations.start_page(params[:start_page].to_i).result_set
#    else
#      @annotations = @book.annotations.result_set
#    end
