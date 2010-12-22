class AddTitleToAnnotations < ActiveRecord::Migration
  def self.up
    add_column :annotations, :title, :string
  end

  def self.down
    remove_column :annotations, :title
  end
end
