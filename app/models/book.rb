class Book < ActiveRecord::Base
  has_many :annotations

  validates_presence_of   :title, :slug, :original_url

  scope :result_set, select([:title, :original_url, :slug])

  def to_s
    title
  end

  # to redefine the resources path to use the slug,
  # since Gaddis is unlikely to publish from beyond
  # the grave, keeping this set limited.
  def to_param
    slug
  end

  def page_range
    annotations.minimum(:page_number)..annotations.maximum(:page_number)
  end
end
