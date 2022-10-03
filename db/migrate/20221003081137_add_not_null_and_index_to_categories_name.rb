class AddNotNullAndIndexToCategoriesName < ActiveRecord::Migration[6.1]
  def change
    change_column :categories, :name, :string, null: false
    add_index :categories, :name, unique: true
  end
end
