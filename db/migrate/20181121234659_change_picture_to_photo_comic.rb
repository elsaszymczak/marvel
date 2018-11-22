class ChangePictureToPhotoComic < ActiveRecord::Migration[5.2]
  def change
    rename_column :comics, :picture, :photo
  end
end
