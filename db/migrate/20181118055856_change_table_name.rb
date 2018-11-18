class ChangeTableName < ActiveRecord::Migration[5.2]
  def change
    rename_table :comic_characters, :joint
  end
end
