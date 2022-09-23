class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :output, null: false, foreign_key: true

      t.timestamps
    end
    add_index :likes, [:user_id, :output_id], unique: true
  end
end
