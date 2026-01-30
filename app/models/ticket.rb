class Ticket < ApplicationRecord
  belongs_to :user
  

  enum :status, { 
    open: 0, 
    awaiting_approval: 1, 
    approved: 2, 
    in_progress: 3, 
    resolved: 4, 
    closed: 5 
  }, default: 0

  validates :title, presence: true
  validates :description, presence: true


  
end
