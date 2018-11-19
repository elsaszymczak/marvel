class AddMarvelIdToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :marvel_id, :integer
  end
end
