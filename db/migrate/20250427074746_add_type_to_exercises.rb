class AddTypeToExercises < ActiveRecord::Migration[8.0]
  def change
    add_column :exercises, :is_time_based, :boolean, default: false, null: false
  end
end
