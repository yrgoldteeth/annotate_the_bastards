class AddOriginalUrlToAnnotations < ActiveRecord::Migration
  def self.up
    add_column :annotations, :original_url, :string
  end

  def self.down
    remove_column :annotations, :original_url
  end
end
