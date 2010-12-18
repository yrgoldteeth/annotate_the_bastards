class BookResponse
  class << self
    def build book, url
      book_hash = book.attributes
      book_hash.delete("slug")
      book_hash["annotations_url"] = url
      book_hash
    end
  end
end
