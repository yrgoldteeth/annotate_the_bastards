class Book < ActiveRecord::Base
  has_many :annotations

  validates_presence_of   :title, :slug, :original_url
  validates_uniqueness_of :title, :slug, :original_url

  def to_s
    title
  end

  def to_param
    slug
  end
end
