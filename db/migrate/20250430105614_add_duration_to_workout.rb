class AddDurationToWorkout < ActiveRecord::Migration[8.0]
  def change
    add_column :workouts, :duration, :integer
  end
end
