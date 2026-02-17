class AddRoleToUsers < ActiveRecord::Migration[8.1]
  def change
  #  add_column :users, :role, :integer, default: 0
   add_column :users, :is_active, :boolean, default: true
   add_column :users, :is_deleted, :boolean, default: false
  end
end
