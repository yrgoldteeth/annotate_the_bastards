class AnnotationsController < ApplicationController
  respond_to :json, :xml
  before_filter :get_book
  before_filter :get_annotation,  :only => [:show]
  before_filter :validate_params, :only => [:index]

  protected
  def get_book
    @book = Book.find_by_slug(params[:book_id])
    unless @book
      response = {:error => %Q(No book found with that id.  Choose one of #{Book.all.map(&:slug)})}
      respond_with response and return
    end
  end

  def get_annotation
    @annotation = @book.annotations.show_format.find_by_id(params[:id])
    unless @annotation
      response = {:error => %(No annotation found with that id.)}
      respond_with response and return
    end
  end

  def validate_params
    keys = %w(start_page before after)
    if (keys & params.keys).count > 1
      response = {:error => %Q(Choose only one param from: #{keys.join(', ')})}
      respond_with response and return
    end

    if params[:start_page].present?
      unless @book.page_range.include?(params[:start_page].to_i)
        response = {:error => %(Not a valid start page.)}
        respond_with response and return
      end
    end

    if params[:before].present?
      unless @book.annotations.find_by_id(params[:before])
        response = {:error => %(No annotation found with that id.)}
        respond_with response and return
      end
    end
    
    if params[:after].present?
      unless @book.annotations.find_by_id(params[:after])
        response = {:error => %(No annotation found with that id.)}
        respond_with response and return
      end
    end
  end

  public
  def index
    if params[:results_count].present?
      count = 1..20.include?(params[:results_count].to_i) ? params[:results_count].to_i : 20
    else
      count = 20
    end
    
    bucket = @book.annotations.index_format.results_count(count)

    if params[:start_page].present?
      bucket = bucket.start_page(params[:start_page].to_i)
    end

    if params[:before].present?
      bucket = bucket.before(@book.annotations.find(params[:before]))
    end

    if params[:after].present?
      bucket = bucket.after(@book.annotations.find(params[:after]))
    end

    response = {}
    response[:annotations] = []
    bucket.each do |annotation|
      response[:annotations] << AnnotationResponse.index_response(annotation, book_annotation_url(@book, annotation))
    end
    respond_with response
  end

  def show
    urls            = {}
    urls[:previous] = book_annotation_url(@book, @annotation.previous_annotation)
    urls[:next]     = book_annotation_url(@book, @annotation.next_annotation)
    response        = AnnotationResponse.show_response(@annotation, urls)
    respond_with response
  end

end
