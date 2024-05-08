class Players < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :name
      t.string :surname
      t.integer :player_number

      t.references :team, foreign_key: true

      t.timestamps

      t.index %i[player_number team_id], unique: true
    end
  end
end
