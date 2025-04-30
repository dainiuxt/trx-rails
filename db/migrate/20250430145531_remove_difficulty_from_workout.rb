class RemoveDifficultyFromWorkout < ActiveRecord::Migration[8.0]
  def change
    remove_column :workouts, :difficulty, :string
  end
end
