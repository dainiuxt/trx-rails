class Exercise < ApplicationRecord
  has_many :plans
  has_many :workouts, through: :plans
  has_rich_text :description

  validates :name, presence: true
end
