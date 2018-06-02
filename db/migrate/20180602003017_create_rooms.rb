class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.float :capacity
      t.string :name
      t.string :info
      t.references :operation_day, foreign_key: true

      t.timestamps
    end
  end
end