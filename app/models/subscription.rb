class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :subscription_teas

  enum status: [:active, :cancelled]
  enum frequency: [:monthly, :quarterly, :anually]

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true
  validates :frequency, presence: true
end
