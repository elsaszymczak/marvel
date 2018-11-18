class AddCoverPictureToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :cover_picture, :string
  end
end
