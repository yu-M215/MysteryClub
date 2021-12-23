class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.bigint :mystery_id, null: false
      t.bigint :user_id, null: false
      t.text :comment, null: false

      t.timestamps
    end
    add_foreign_key :comments, :users
    add_foreign_key :comments, :mysteries
  end
end
