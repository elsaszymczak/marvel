class AddMarvelIdToComic < ActiveRecord::Migration[5.2]
  def change
    add_column :comics, :marvel_id, :integer
  end
end
