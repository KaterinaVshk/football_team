class MatchIndicator < ApplicationRecord
  belongs_to :player
  belongs_to :indicator
  belongs_to :match

  validates :indicator_id, uniqueness: { scope: %i[player_id match_id] }
end
