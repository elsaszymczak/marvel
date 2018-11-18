class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.string :picture
      t.string :name
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
