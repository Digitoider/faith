class CreateOperationDays < ActiveRecord::Migration[5.2]
  def change
    create_table :operation_days do |t|
      t.date :at

      t.timestamps
    end
  end
end
2905