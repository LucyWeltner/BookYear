class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.integer :list_id
      t.integer :book_id
      t.text :comments

      t.timestamps
    end
  end
end
