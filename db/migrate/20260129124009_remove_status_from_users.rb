class RemoveStatusFromUsers < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :status, :integer
  end
end
