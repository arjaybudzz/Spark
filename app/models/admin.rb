class Admin < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :middle_name, length: { minimum: 2, maximum: 30 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                                    format:     { with: VALID_EMAIL_REGEX },
                                    length:     { minimum: 10, maximum: 30 }


  has_secure_password

  validates :password, length: { minimum: 8, maximum: 20 }
end
