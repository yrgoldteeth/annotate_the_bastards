class AnnotationResponse
  class << self
    def index_collection annotation, url
      annotation_hash = annotation.attributes
      annotation_hash.delete("id")
      annotation_hash.delete("body")
      annotation_hash["annotation_url"] = url
      annotation_hash
    end
  end
end
