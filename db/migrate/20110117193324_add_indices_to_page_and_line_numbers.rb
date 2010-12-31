class AddIndicesToPageAndLineNumbers < ActiveRecord::Migration
  def self.up
    add_index :annotations, :page_number
    add_index :annotations, :line_number
  end

  def self.down
    remove_index :annotations, :column => :line_number
    remove_index :annotations, :column => :page_number
  end
end
