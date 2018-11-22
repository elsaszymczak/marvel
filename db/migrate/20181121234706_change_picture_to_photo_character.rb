class ChangePictureToPhotoCharacter < ActiveRecord::Migration[5.2]
  def change
    rename_column :characters, :picture, :photo
  end
end
