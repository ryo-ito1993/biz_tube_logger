class CreateOutputs < ActiveRecord::Migration[6.1]
  def change
    create_table :outputs do |t|
      t.text :summary, null:false
      t.text :impression, null:false
      t.references :user, null: false, foreign_key: true
      t.references :video, null: false, foreign_key: true

      t.timestamps
    end
  end
end
