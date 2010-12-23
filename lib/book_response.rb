class BookResponse
  class << self
    def build book, url
      book_hash = book.attributes
      book_hash.delete("slug")
      book_hash["url"] = url
      book_hash
    end
  end
end
