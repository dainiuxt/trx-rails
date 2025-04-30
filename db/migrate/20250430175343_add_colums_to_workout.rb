class AddColumsToWorkout < ActiveRecord::Migration[8.0]
  def change
    add_column :workouts, :difficulty_id, :integer
    add_column :workouts, :workout_type, :integer
  end
end
