class AddIndexUserIdAndVideoIdToBookmarks < ActiveRecord::Migration[6.1]
  def change
    add_index :bookmarks, [:user_id, :video_id], unique: true
  end
end
