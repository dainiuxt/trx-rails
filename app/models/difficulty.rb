class Difficulty < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :exercises
  has_many :workouts
end
