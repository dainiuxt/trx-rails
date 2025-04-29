class AddColumnsToExercises < ActiveRecord::Migration[8.0]
  def change
    add_column :exercises, :plans, :integer
    add_column :exercises, :difficulty, :string
  end
end
