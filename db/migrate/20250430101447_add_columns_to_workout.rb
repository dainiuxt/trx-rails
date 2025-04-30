class AddColumnsToWorkout < ActiveRecord::Migration[8.0]
  def change
    add_column :workouts, :difficulty, :string
  end
end
