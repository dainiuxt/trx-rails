class MuscleGroup < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :exercise_muscles
  has_many :exercises, through: :exercise_muscles
end
