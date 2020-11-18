class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|

      t.integer :custmer_id
      t.integer :genre_id
      t.string :image_id
      t.string :title
      t.text :explanation
      t.timestamps
    end
  end
end
