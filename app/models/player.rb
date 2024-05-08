class Player < ApplicationRecord
  validates :name, presence: true
  validates :player_number, presence: true

  validates :player_number, uniqueness: { scope: :team_id }

  belongs_to :team

  has_many :match_indicators
  has_many :indicators, through: :match_indicators
end
