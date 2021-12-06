class ChangeDataImageIdToMysteries < ActiveRecord::Migration[5.2]
  def change
    change_column :mysteries, :image_id, :string
  end
end
