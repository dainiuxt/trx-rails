class Workout < ApplicationRecord
  has_many :plans
  has_many :exercises, through: :plans
  has_rich_text :description

  validates :name, presence: true
end
