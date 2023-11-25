class Customer < ApplicationRecord
  has_many :subscriptions, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensite: false }
  validates :address, presence: true
end
