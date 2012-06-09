class User < ActiveRecord::Base
  attr_accessible :name, :email
  before_save :downcase_email

  validates :name, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  private

    def downcase_email
      self.email = self.email.downcase
    end
end
