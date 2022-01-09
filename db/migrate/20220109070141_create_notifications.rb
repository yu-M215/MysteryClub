class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.timestamps
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :mystery_id
      t.integer :comment_id
      t.integer :chat_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false
    end
    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :mystery_id
    add_index :notifications, :comment_id
    add_index :notifications, :chat_id
  end
end
