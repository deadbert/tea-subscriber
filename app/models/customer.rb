class Customer < ApplicationRecord
  has_many :subscriptions
  has_many :teas, through: :subscriptions

  has_secure_password
end
