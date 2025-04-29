class CreateMuscleGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :muscle_groups do |t|
      t.timestamps
    end
  end
end
