class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  scope :create_desc, ->{order created_at: :desc}

  REVIEW_PARAMS = %i(product_id content rate).freeze

  validates :content, presence: true,
    length: {maximum: Settings.max_content}
end
