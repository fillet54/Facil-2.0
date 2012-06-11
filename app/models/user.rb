class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :name, :email, :password, :password_confirmation 

  before_save :downcase_email
  before_create { generate_token(:remember_token) }

  validates :name, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private

    def downcase_email
      self.email = self.email.downcase
    end

    def generate_token(column)
      begin 
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end
end
