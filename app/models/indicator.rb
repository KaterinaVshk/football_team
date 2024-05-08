class Indicator < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255, minimum: 2 }, uniqueness: true

  has_many :match_indicators
  has_many :players, through: :match_indicators
end
