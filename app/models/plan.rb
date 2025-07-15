class Plan < ApplicationRecord
  belongs_to :workout
  belongs_to :exercise

  before_validation :assign_position_if_needed
  before_validation :normalize_is_time_based

  validate :must_have_valid_params_set
  validate :unique_position_within_workout

  validates :sets, :reps, numericality: { only_integer: true }, allow_nil: true
  validates :duration_time, numericality: { only_integer: true }, allow_nil: true
  validates :rest, numericality: { only_integer: true }, allow_nil: true
  validates :is_time_based, inclusion: { in: [ true, false ] }
  validates :exercise_id, presence: true

  after_initialize :set_defaults, if: :new_record?

  def normalize_is_time_based
    self.is_time_based = ActiveModel::Type::Boolean.new.cast(is_time_based)
  end

  def unique_position_within_workout
    return if marked_for_destruction? || workout.nil?
    siblings = workout.plans.reject(&:marked_for_destruction?)
    duplicates = siblings.group_by(&:position).select { |_, v| v.size > 1 }
    if duplicates.any?
      errors.add(:position, "has already been taken")
    end
  end

  def set_defaults
    self.sets = 3 if sets.nil?
    self.reps = 10 if reps.nil?
    self.rest = 30 if rest.nil?
    self.duration_time = 0 if duration_time.nil?
    self.is_time_based = false if is_time_based.nil?
  end

  def assign_position_if_needed
    if position.blank?
      self.position = Plan.where(workout_id: workout_id).maximum(:position).to_i + 1
    end
  end

  def must_have_valid_params_set
    if is_time_based
      errors.add(:base, "Missing or invalid time-based fields") if
        duration_time.to_i <= 0 || sets.to_i <= 0 || rest.to_i <= 0
    else
      errors.add(:base, "Missing or invalid rep-based fields") if
        sets.to_i <= 0 || reps.to_i <= 0 || rest.to_i <= 0
    end
  end
end
