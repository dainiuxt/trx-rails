class RemoveUnusedColumnsFromExercise < ActiveRecord::Migration[8.0]
  def change
    remove_column :exercises, :difficulty, :string
    remove_column :exercises, :category, :string
  end
end
