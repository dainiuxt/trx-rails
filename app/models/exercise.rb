class Exercise < ApplicationRecord
  has_many :suites
  has_many :workouts, :through :suites
  has_rich_text :description

  validates: name, presence :true
end
