class MakePlansPositionIndexDeferrable < ActiveRecord::Migration[8.0]
  def up
    # Remove existing unique index
    remove_index :plans, name: "index_plans_on_workout_id_and_position"

    # Add deferrable unique constraint instead
    execute <<-SQL
      ALTER TABLE plans
      ADD CONSTRAINT unique_workout_id_position
      UNIQUE (workout_id, position)
      DEFERRABLE INITIALLY DEFERRED;
    SQL
  end

  def down
    # Remove the deferrable constraint
    execute <<-SQL
      ALTER TABLE plans
      DROP CONSTRAINT unique_workout_id_position;
    SQL

    # Re-add the regular index
    add_index :plans, [ :workout_id, :position ], unique: true, name: "index_plans_on_workout_id_and_position"
  end
end
