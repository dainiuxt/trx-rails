class RenameWorkoutTypeToWorkoutTypeIdInWorkout < ActiveRecord::Migration[8.0]
  def change
    rename_column :workouts, :workout_type, :workout_type_id
  end
end
