class ChangeDataAnswerImageIdToMysteries < ActiveRecord::Migration[5.2]
  def change
    change_column :mysteries, :answer_image_id, :string
  end
end
