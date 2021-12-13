class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.bigint :mystery_id, null: false
      t.bigint :user_id, null: false

      t.timestamps

    end
    add_foreign_key :favorites, :users
    add_foreign_key :favorites, :mysteries
  end
end
