class CreateReadBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :read_books do |t|
      t.integer :user_id
      t.integer :book_id
      t.date :date_read

      t.timestamps
    end
  end
end
