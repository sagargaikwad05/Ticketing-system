class Ticket < ApplicationRecord
  belongs_to :user
   belongs_to :agent, class_name: "User", optional: true
  

  enum :status, { 
    open: 0, 
    awaiting_approval: 1, 
    approved: 2, 
    in_progress: 3, 
    resolved: 4, 
    closed: 5 
 

  }, default: 0

  enum :priority, {
    high: 1,
    medium: 2,
    low: 3
  }

  validates :title, presence: true
  validates :description, presence: true

    scope :active_user, ->{where(is_delete: false)}
    scope :unassigned, ->{where(agent_id: nil)}
  
end
