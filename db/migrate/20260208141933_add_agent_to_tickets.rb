class AddAgentToTickets < ActiveRecord::Migration[8.1]
  def change
    add_column :tickets, :agent_id, :integer
    add_column :tickets, :priority, :integer
  end
end
