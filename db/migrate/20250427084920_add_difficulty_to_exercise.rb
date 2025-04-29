class AddDifficultyToExercise < ActiveRecord::Migration[8.0]
  def change
    add_column :exercises, :difficulty_id, :integer
  end
end
