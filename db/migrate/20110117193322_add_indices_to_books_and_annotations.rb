class AddIndicesToBooksAndAnnotations < ActiveRecord::Migration
  def self.up
    add_index :books, :slug, :unique => true
    add_index :annotations, :book_id
  end

  def self.down
    remove_index :annotations, :column => :book_id
    remove_index :books, :column => :slug
  end
end
