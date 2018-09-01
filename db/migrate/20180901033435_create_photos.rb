class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :title
      t.string :filename
      t.integer :user_id
      t.timestamps
    end
  end
end
