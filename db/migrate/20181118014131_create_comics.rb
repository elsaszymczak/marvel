class CreateComics < ActiveRecord::Migration[5.2]
  def change
    create_table :comics do |t|
      t.string :picture
      t.string :name
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
