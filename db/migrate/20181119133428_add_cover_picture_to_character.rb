class AddCoverPictureToCharacter < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :cover_picture, :string
  end
end
