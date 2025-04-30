class DropColumnsForWorkouts < ActiveRecord::Migration[8.0]
  def change
    drop_table :columns_for_workouts
  end
end
