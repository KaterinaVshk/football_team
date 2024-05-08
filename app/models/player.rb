class Player < ApplicationRecord
  validates :name, presence: true
  validates :surname, presence: true
  validates :player_number, presence: true

  validates :player_number, uniqueness: { scope: :team_id }

  belongs_to :team
end
