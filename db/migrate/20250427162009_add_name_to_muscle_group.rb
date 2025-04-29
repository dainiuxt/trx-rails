class AddNameToMuscleGroup < ActiveRecord::Migration[8.0]
  def change
    add_column :muscle_groups, :name, :string
  end
end
