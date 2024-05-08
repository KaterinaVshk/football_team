class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :country_name

      t.timestamps

      t.index %i[name country_name], unique: true
    end
  end
end
