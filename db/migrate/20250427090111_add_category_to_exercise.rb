class AddCategoryToExercise < ActiveRecord::Migration[8.0]
  def change
    add_column :exercises, :category_id, :integer
  end
end
