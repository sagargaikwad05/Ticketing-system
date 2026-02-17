class User < ApplicationRecord
    has_secure_password 
     before_save :downcase_email
     has_many :tickets
     has_many :agents

    validates :user_name, presence: , if: :will_save_change_to_user_name?
    enum :role, {user: 0, admin: 1, agent: 2 }, default: 0 
    validates :email, presence: true, uniqueness: true,
                   format: { with: /\A[a-zA-Z0-9.\-_]+@[a-zA-Z0-9\-.]+\.[a-zA-Z]+\z/,
                    message: "only allows letters, numbers, dots, hyphens, and underscores" }, if: :will_save_change_to_email?

    validates :password, presence: true,
            format: {
              with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}\z/,
              message: "must include uppercase, lowercase, number, and special character"
            }, if: :will_save_change_to_password_digest?




   private         
     
    def downcase_email
      self.email = email.downcase 
    end



end
