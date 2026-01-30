class ChangeDataTypeForTickets < ActiveRecord::Migration[8.1]
  def change
      change_column :tickets, :status, :integer
  end
end
