class AddAdditionalAttrsToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :name, :string
    add_column :profiles, :surname, :string
    add_column :profiles, :middlename, :string
    add_column :profiles, :age, :integer
  end
end
