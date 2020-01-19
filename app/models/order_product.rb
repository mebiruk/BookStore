class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :num_product, presence: true,
    numericality: {greater_than: Settings.min_op}
end
