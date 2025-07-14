class Workout < ApplicationRecord
  has_rich_text :workout_description
  belongs_to :difficulty
  belongs_to :workout_type

  has_many :plans, -> { order(:position) }, inverse_of: :workout, dependent: :destroy
  accepts_nested_attributes_for :plans,
                                allow_destroy: true,
                                reject_if: ->(attrs) {
                                            attrs[:_destroy].blank? && attrs.except(:_destroy).values.all?(&:blank?)
                                            }
  has_many :exercises, through: :plans

  validates :name, presence: true
  validates :duration, numericality: { only_integer: true }

  before_validation :normalize_plan_positions

  def normalize_plan_positions
    plans.reject(&:marked_for_destruction?).sort_by(&:position).each_with_index do |plan, index|
      plan.position = index + 1
    end
  end
end
