class AddCategoryToExercises < ActiveRecord::Migration[8.0]
  def change
    add_column :exercises, :category, :string
  end
end
