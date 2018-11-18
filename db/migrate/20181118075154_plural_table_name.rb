class PluralTableName < ActiveRecord::Migration[5.2]
  def change
    rename_table :comic_character, :comic_characters
  end
end
