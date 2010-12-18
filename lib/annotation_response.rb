class AnnotationResponse
  class << self
    def index_response annotation, url
      {:description => annotation.to_s, :annotation_url => url}
    end

    def show_response annotation, urls={}
      annotation_hash = annotation.attributes
      annotation_hash.delete("id")
      annotation_hash.merge(urls)
    end
  end
end
