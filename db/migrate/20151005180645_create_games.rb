class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.string :short_title, null: false

      t.timestamps null: false
    end
  end
end
