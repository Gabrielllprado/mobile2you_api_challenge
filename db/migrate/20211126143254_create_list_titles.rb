class CreateListTitles < ActiveRecord::Migration[6.1]
  def change
    create_table :list_titles do |t|
      t.string :show_id
      t.string :title
      t.string :type
      t.string :director
      t.string :cast
      t.string :country
      t.datetime :date_added
      t.integer :release_year
      t.string :rating
      t.string :duration
      t.string :listed_in
      t.string :description
      t.timestamps
    end
  end
end
