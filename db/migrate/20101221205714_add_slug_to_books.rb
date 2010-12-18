class AddSlugToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :slug, :string
  end

  def self.down
    remove_column :books, :slug
  end
end
