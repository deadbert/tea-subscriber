class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  enum status: [:cancelled, :active]
  enum frequency: [:monthly, :weekly]
end
