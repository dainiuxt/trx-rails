class ChangeDifficultyTypeInExercises < ActiveRecord::Migration[8.0]
  def change
    change_column :exercises, :difficulty, :string
    # Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
