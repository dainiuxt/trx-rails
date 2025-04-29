class AddTrainingRecommendationsToExercises < ActiveRecord::Migration[8.0]
  def change
    add_column :exercises, :sets, :integer
    add_column :exercises, :reps, :integer
    add_column :exercises, :rest, :integer
    add_column :exercises, :duration_time, :integer
  end
end
