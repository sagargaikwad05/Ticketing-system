class User < ApplicationRecord
  has_secure_password
 
  has_many :tickets

  validates :username, presence: true
  # validates :email, presence: true, uniqueness: true
  validate :set_email 

   validates :email, presence: true, uniqueness: { case_sensitive: false }, 
      format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email address" }

   validates :password,
    format: {
      with: /\A(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&]).{8,}\z/,
      message: "must include uppercase, lowercase, number, and special character"
    }

    def set_email
      self.email = email.downcase
    end
  
end