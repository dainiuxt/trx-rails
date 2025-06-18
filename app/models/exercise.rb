class Exercise < ApplicationRecord
  has_many :plans, dependent: :destroy
  has_many :workouts, through: :plans

  has_many :exercise_muscles, dependent: :destroy
  has_many :muscle_groups, through: :exercise_muscles
  after_save :update_muscle_groups
  after_save :update_workouts

  def muscle_group_ids
    @muscle_group_ids || muscle_groups.pluck(:id).map(&:to_i)
  end

  def workout_ids
    @workout_ids || workouts.pluck(:id).map(&:to_i)
  end

  has_one_attached :featured_image
  has_rich_text :description
  has_rich_text :instructions
  has_rich_text :tips
  has_rich_text :precautions
  belongs_to :difficulty
  belongs_to :category

  validates :name, presence: true
  validates :difficulty_id, presence: true
  validates :category_id, presence: true
  validates :sets, presence: true, numericality: { only_integer: true }
  validates :rest, presence: true, numericality: { only_integer: true }
  validates :reps, numericality: { only_integer: true }

  attr_accessor :workout_ids
  attr_accessor :muscle_group_ids

  private

  def update_muscle_groups
    # Convert string IDs to integers
    desired_ids = Array(muscle_group_ids).reject(&:blank?).map(&:to_i)

    # Remove unwanted associations
    exercise_muscles.where.not(muscle_group_id: desired_ids).destroy_all

    # Add new associations
    existing_ids = exercise_muscles.pluck(:muscle_group_id)
    (desired_ids - existing_ids).each do |id|
      exercise_muscles.create!(muscle_group_id: id)
    end
  end

  def update_workouts
    desired_ids = Array(workout_ids).reject(&:blank?).map(&:to_i)

    plans.where.not(workout_id: desired_ids).destroy_all

    existing_ids = plans.pluck(:workout_id)
    (desired_ids - existing_ids).each do |id|
      plans.create!(workout_id: id)
    end
  end
end
