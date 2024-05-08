class Indicator < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255, minimum: 2 }, uniqueness: true

  has_many :players, dependent: :delete_all
end
