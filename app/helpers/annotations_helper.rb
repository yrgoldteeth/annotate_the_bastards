module AnnotationsHelper
  def previous_link annotations
    if annotations.first.previous_annotation
      link_to "Previous Page", annotations.first.previous_annotation.page_number_link
    else
      "..."
    end
  end

  def next_link annotations
    if annotations.last.next_annotation
      link_to "Next Page", annotations.last.next_annotation.page_number_link
    else
      "..."
    end
  end
end
