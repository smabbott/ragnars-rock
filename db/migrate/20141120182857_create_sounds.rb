class CreateSounds < ActiveRecord::Migration
  def change
    create_table :sounds do |t|
      t.string :name
      t.string :author
      t.integer :location_id

      t.timestamps
    end
  end
end
