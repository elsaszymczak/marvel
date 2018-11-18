class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :wiki_link
      t.string :start_date
      t.string :end_date

      t.timestamps
    end
  end
end
