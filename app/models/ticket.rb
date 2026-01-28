class Ticket < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :status, presence: true, default: "open"
end
