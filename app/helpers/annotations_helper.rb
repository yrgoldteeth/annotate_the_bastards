module AnnotationsHelper
  def page_link book, page_number
    link_to "Notes for page #{page_number}", %Q(/books/#{book}/annotations/page/#{page_number})
  end

  def previous_link annotations
    _a = annotations.first
    if _a.previous_annotation
      link_to "#{_a.previous_annotation.page_number}", _a.previous_annotation.page_number_link
    else
      link_to "Back", book_annotations_path(annotations.first.book)
    end
  end

  def next_link annotations
    if annotations.last.next_annotation
      link_to "#{annotations.last.next_annotation.page_number}", annotations.last.next_annotation.page_number_link
    else
      link_to "Back", book_path(annotations.first.book)
    end
  end
end
