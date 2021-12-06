class CreateMysteries < ActiveRecord::Migration[5.2]
  def change
    create_table :mysteries do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :discription, null: false
      t.integer :image_id
      t.string :answer, null: false
      t.integer :answer_image_id
      t.text :answer_discription, null: false
      t.float :difficultty_level, null: false, default: 3
      t.boolean :is_opened, null: false, default: true

      t.timestamps
    end
  end
end
