class CreateComicCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :comic_characters do |t|
      t.references :comic, foreign_key: true
      t.references :character, foreign_key: true

      t.timestamps
    end
  end
end
