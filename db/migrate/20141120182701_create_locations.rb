class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.text :coordinates, array: true, default: []
      t.string :name

      t.timestamps
    end
  end
end
