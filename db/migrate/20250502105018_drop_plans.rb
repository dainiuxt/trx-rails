class DropPlans < ActiveRecord::Migration[8.0]
  def change
    drop_table :plans
  end
end
