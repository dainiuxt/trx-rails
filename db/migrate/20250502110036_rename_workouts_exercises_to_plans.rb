class RenameWorkoutsExercisesToPlans < ActiveRecord::Migration[8.0]
  def change
    rename_table :workout_exercises, :plans
  end
end
