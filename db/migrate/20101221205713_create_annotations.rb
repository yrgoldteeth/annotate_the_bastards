class CreateAnnotations < ActiveRecord::Migration
  def self.up
    create_table :annotations do |t|
      t.text :body
      t.integer :book_id
      t.integer :page_number
      t.integer :line_number

      t.timestamps
    end
  end

  def self.down
    drop_table :annotations
  end
end
