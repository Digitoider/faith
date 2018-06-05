class AddAssignedToOperation < ActiveRecord::Migration[5.2]
  def change
    add_column :operations, :assigned, :boolean, default: false
  end
end
