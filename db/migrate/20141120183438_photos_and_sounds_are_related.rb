class PhotosAndSoundsAreRelated < ActiveRecord::Migration
  def change
    create_table :photos_sounds do |t|
      t.integer :sound_id
      t.integer :photo_id
    end
  end
end
