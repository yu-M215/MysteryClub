class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :mystery_id, null: false
      t.integer :user_id, null: false
      t.text :comment, null: false

      t.timestamps

      add_foreign_key :comments, :users
      add_foreign_key :comments, :mysteries
    end
  end
end
