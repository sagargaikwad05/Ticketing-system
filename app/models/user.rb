class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, 
    format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email address" }

  PASSWORD_FORMAT = /\A
    (?=.{8,})          # Must contain 8 or more characters
    (?=.*\d)            # Must contain at least one digit
    (?=.*[a-z])         # Must contain at least one lowercase letter
    (?=.*[A-Z])         # Must contain at least one uppercase letter
    (?=.*[[:^alnum:]])  # Must contain at least one symbol
  \x/

  validates :password, presence: true, format: { with: PASSWORD_FORMAT, message: "must meet complexity requirements" }
end