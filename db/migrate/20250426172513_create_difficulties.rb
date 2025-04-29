class CreateDifficulties < ActiveRecord::Migration[8.0]
  def change
    create_table :difficulties do |t|
      t.string :name

      t.timestamps
    end
  end
end
