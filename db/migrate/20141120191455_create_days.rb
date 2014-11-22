class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.datetime :date
      t.text :path, array: true

      t.timestamps
    end
    add_column :locations, :day_id, :integer
  end
end
