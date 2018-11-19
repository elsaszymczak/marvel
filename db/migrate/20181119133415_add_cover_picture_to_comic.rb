class AddCoverPictureToComic < ActiveRecord::Migration[5.2]
  def change
    add_column :comics, :cover_picture, :string
  end
end
