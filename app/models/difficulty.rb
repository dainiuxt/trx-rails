class Difficulty < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :exercises
end
