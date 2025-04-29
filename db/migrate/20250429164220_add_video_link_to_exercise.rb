class AddVideoLinkToExercise < ActiveRecord::Migration[8.0]
  def change
    add_column :exercises, :video_link, :string
  end
end
