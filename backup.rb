class CreateAnalyses < ActiveRecord::Migration[5.2]
  def change
    create_table :analyses do |t|
      t.references :profile, foreign_key: true
      t.text :analysis
      t.date :received_at
      t.boolean :operation_required
      t.float :min_duration
      t.float :max_duration

      t.timestamps
    end
  end
end

class CreateOperationDays < ActiveRecord::Migration[5.2]
  def change
    create_table :operation_days do |t|
      t.date :at
      t.float :capacity

      t.timestamps
    end
  end
end


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

class Operation < ApplicationRecord
  belongs_to :operation_day, optional: true
  belongs_to :analysis
end

class OperationDay < ApplicationRecord
  has_many :operations
end

