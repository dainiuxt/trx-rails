class CreateColumnsForWorkout < ActiveRecord::Migration[8.0]
  def change
    create_table :columns_for_workouts do |t|
      t.integer :difficulty_id
      t.integer :workout_type_id

      t.timestamps
    end
  end
end
