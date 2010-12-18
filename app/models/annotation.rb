class Annotation < ActiveRecord::Base
  belongs_to :book
  validates_presence_of   :title, :body, :original_url, :page_number, :line_number

  scope :index_format,       limit(10).select([:id, :page_number, :line_number, :title])
  scope :show_format,        select([:id, :page_number, :line_number, :title, :body, :original_url])
  scope :ordered,            order("annotations.page_number, annotations.line_number ASC")
  scope :reverse_ordered,    order("annotations.page_number DESC").order("annotations.line_number DESC")
  scope :for_book,           lambda {|book| ordered.where('annotations.book_id = ?', book.id)}
  scope :start_page,         lambda {|page| ordered.where('annotations.page_number >= ?', page)}
  scope :before,             lambda {|annotation| 
                                page = annotation.page_number
                                line = annotation.line_number
                                reverse_ordered.where(
                                  '(annotations.page_number = ? AND annotations.line_number < ?) OR annotations.page_number < ?', page, line, page)}
  scope :after,              lambda {|annotation| 
                                page = annotation.page_number
                                line = annotation.line_number
                                ordered.where(
                                  '(annotations.page_number = ? AND annotations.line_number > ?) OR annotations.page_number > ?', page, line, page)}


  # page_number.line_number - title
  def to_s
    %Q(#{page_number}.#{line_number} - #{title})
  end

  def next_annotation
    Annotation.for_book(book).after(self).first
  end

  def previous_annotation
    Annotation.for_book(book).before(self).last
  end
end
