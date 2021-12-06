class RenameDifficulttyLevelColumnToMysteries < ActiveRecord::Migration[5.2]
  def change
    rename_column :mysteries, :difficultty_level, :difficulty_level
  end
end
