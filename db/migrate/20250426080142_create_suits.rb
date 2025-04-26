class CreateSuits < ActiveRecord::Migration[8.0]
  def change
    create_table :suits do |t|
      t.timestamps
    end
  end
end
