class AddMarvelIdToCharacter < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :marvel_id, :integer
  end
end
