class Plan < ApplicationRecord
  belongs_to :workout
  belongs_to :exercise

  validates :sets, :reps, numericality: { only_integer: true }, allow_nil: true
  validates :duration, numericality: { only_integer: true }, allow_nil: true
  validates :rest, numericality: { only_integer: true }, allow_nil: true
  validates :is_time_based, inclusion: { in: [ true, false ] }
  validates :position, presence: true, numericality: { only_integer: true }, uniqueness: { scope: :workout_id }

  validate :must_have_valid_params_set

  before_validation :assign_position_if_needed

  def assign_position_if_needed
    if position.blank?
      self.position = Plan.where(workout_id: workout_id).maximum(:position).to_i + 1
    end
  end

  def must_have_valid_params_set
    if duration.blank? && (sets.blank? || reps.blank?)
      errors.add(:base, "Either duration or both sets and reps must be present")
    end
  end
end
