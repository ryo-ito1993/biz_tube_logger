class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.string :youtube_id, null:false, unique: true
      t.string :title, null:false
      t.integer :view_count, null:false
      t.datetime :published_at, null:false
      t.string :thumbnail, null:false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
