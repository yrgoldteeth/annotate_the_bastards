class Annotation < ActiveRecord::Base
  belongs_to :book

  scope :ordered, order("annotations.page_number, annotations.line_number ASC")
end
