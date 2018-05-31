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
