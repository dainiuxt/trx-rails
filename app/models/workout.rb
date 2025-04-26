class Workout < ApplicationRecord
  has_many :suites
  has_many :exercises, :through :suites
  has_rich_text :description
  
  validates :name, presence: true
end
