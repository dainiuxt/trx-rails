class AddNameColumnToWorkouttype < ActiveRecord::Migration[8.0]
  def change
    add_column :workout_types, :name, :string
  end
end
