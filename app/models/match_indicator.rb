class MatchIndicator < ApplicationRecord
  belongs_to :player
  belongs_to :indicator
  belongs_to :match
end
