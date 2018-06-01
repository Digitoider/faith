class CreateOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :operations do |t|
      t.time :starts_at
      t.time :ends_at
      t.boolean :is_operated, default: false
      t.references :operation_day, foreign_key: true
      t.references :analysis, foreign_key: true

      t.timestamps
    end
  end
end
