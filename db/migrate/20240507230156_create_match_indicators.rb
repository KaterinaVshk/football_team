class CreateMatchIndicators < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.references :first_team, foreign_key: { to_table: :teams }
      t.references :second_team, foreign_key: { to_table: :teams }
      t.datetime :ended_at

      t.timestamps
    end

    create_table :match_indicators do |t|
      t.references :player, foreign_key: true
      t.references :indicator, foreign_key: true
      t.references :match, foreign_key: true

      t.timestamps

      t.index %i[player_id indicator_id match_id],
              name: 'index_match_indicators_on_player_indicator_and_match',
              unique: true
    end
  end
end
