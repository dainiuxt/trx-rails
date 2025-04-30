class Workout < ApplicationRecord
  # has_many :plans
  # has_many :exercises, through: :plans
  has_rich_text :workout_description
  belongs_to :difficulty
  belongs_to :workout_type

  validates :name, presence: true
  validates :duration, numericality: { only_integer: true }
end
