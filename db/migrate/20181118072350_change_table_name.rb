class ChangeTableName < ActiveRecord::Migration[5.2]
  def change
    rename_table :joint, :comic_character
  end
end
