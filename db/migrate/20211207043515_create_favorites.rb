class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :mystery_id, null: false
      t.integer :user_id, null: false

      t.timestamps

      add_foreign_key :favorites, :users
      add_foreign_key :favorites, :mysteries
    end
  end
end
