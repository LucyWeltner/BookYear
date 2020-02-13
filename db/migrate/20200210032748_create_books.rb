class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :author_id
      t.text :blurb
      t.string :cover_image_url

      t.timestamps
    end
  end
end
