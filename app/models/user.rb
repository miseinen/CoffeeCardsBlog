class User < ApplicationRecord
  before_create :confirmation_token
  before_save { self.email = email.downcase }

  has_many :coffeecards, dependent: :destroy
  has_many :likes, dependent: :destroy

  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+\z/
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       format: { with: VALID_USERNAME_REGEX },
                       length: 3..25

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX },
                    length: { maximum: 105 },
                    confirmation: true

  has_secure_password

  VALID_ABOUT_REGEX = /^[a-zA-Z0-9]+$/
  validates :about, allow_blank: true,
                    format: { with: VALID_ABOUT_REGEX, multiline: true },
                    length: 0..250
                   

  VALID_PASSWORD_REGEX = /\A(?=.*\d)(?=.*([a-z]))(?=.*[@#$%^&+=]){8,}\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX }

  def send_password_reset
    generate_token(:reset_password_token)
    self.reset_password_sent_at = Time.zone.now
    save!
    UserMailer.forgot_password(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
