class AddApprovalStatusToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :status, :string, default: 'pending'
    add_column :users, :approved_at, :datetime
    add_index :users, :status
  end
end
