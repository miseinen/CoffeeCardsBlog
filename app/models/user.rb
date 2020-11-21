class User < ApplicationRecord
  before_save { self.email = email.downcase }

  has_many :articles, dependent: :destroy

  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: 3..25

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX },
                    length: { maximum: 105 },
                    confirmation: true

  has_secure_password

  validates :about, length: 0..250, allow_blank: true
end
