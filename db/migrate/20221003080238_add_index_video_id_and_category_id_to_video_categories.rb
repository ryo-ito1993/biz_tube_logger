class AddIndexVideoIdAndCategoryIdToVideoCategories < ActiveRecord::Migration[6.1]
  def change
    add_index :video_categories, [:video_id, :category_id], unique: true
  end
end
