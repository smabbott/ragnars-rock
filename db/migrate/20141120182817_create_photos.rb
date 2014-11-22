class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :author
      t.integer :location_id
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
