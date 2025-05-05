class Workout < ApplicationRecord
  has_rich_text :workout_description
  belongs_to :difficulty
  belongs_to :workout_type

  has_many :plans, dependent: :destroy
  has_many :exercises, through: :plans
  after_save :update_exercises

  validates :name, presence: true
  validates :duration, numericality: { only_integer: true }

  def exercise_ids
    @exercise_ids || exercises.pluck(:id).map(&:to_i)
  end

  attr_accessor :exercise_ids

  private

  def update_exercises
    # Convert string IDs to integers
    desired_ids = exercise_ids.reject(&:blank?).map(&:to_i)

    # Remove unwanted associations
    plans.where.not(exercise_id: desired_ids).destroy_all

    # Add new associations
    existing_ids = plans.pluck(:exercise_id)
    (desired_ids - existing_ids).each do |id|
      plans.create!(exercise_id: id)
    end
  end
end
