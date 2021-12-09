class Invoice < ApplicationRecord 
  belongs_to :merchant
  belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy
  has_many :merchants, through: :items

  validates :status, presence: true
end
