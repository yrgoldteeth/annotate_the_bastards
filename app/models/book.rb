class Book < ActiveRecord::Base
  has_many :annotations

  validates_presence_of :title, :slug, :original_url, :amazon_url

  class << self
    def slug_list
      Book.all.map(&:slug).join(', ')
    end
  end

  def to_s
    title
  end

  # to redefine the resources path to use the slug,
  # since Gaddis is unlikely to publish from beyond
  # the grave, keeping this set limited.
  def to_param
    slug
  end
end
