class Team < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :country_name, presence: true, length: { maximum: 255, minimum: 2 }

  has_many :players, dependent: :destroy
  has_many :matches, dependent: :destroy

  validates :name, uniqueness: { scope: :country_name }
end
