class Plan < ApplicationRecord
  belongs_to :workout
  belongs_to :exercise

  validates :sets, :reps, numericality: { only_integer: true }, allow_nil: true
  validates :duration_time, numericality: { only_integer: true }, allow_nil: true
  validates :rest, numericality: { only_integer: true }, allow_nil: true
  validates :is_time_based, inclusion: { in: [ true, false ] }

  validates :exercise_id, presence: true

  validate :must_have_valid_params_set
  validate :unique_position_within_workout

  before_validation :assign_position_if_needed

  after_initialize :set_defaults, if: :new_record?

  def unique_position_within_workout
    return if marked_for_destruction? || workout.nil?

    # Select all plans for the workout (including unsaved nested ones)
    siblings = workout.plans.reject(&:marked_for_destruction?)

    duplicates = siblings.group_by(&:position).select { |_, v| v.size > 1 }

    if duplicates.any?
      errors.add(:position, "has already been taken")
    end
  end

  def set_defaults
    self.sets ||= 3
    self.reps ||= 10
    self.rest ||= 30
    self.duration_time ||= 0
    self.is_time_based = false if is_time_based.nil?
  end

  def assign_position_if_needed
    if position.blank?
      self.position = Plan.where(workout_id: workout_id).maximum(:position).to_i + 1
    end
  end

  def must_have_valid_params_set
    if duration_time.blank? && (sets.blank? || reps.blank?)
      errors.add(:base, "Either duration time or both sets and reps must be present")
    end
  end
end
