class Book < ActiveRecord::Base
  has_many :annotations
end
