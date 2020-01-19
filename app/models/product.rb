class Product < ApplicationRecord
  belongs_to :category
  has_many :reviews
  has_many :order_products

  mount_uploader :picture, PictureUploader

  validates :title, presence: true,
    length: {maximum: Settings.maximum_length_name}
  validates :publisher_name, presence: true,
    length: {maximum: Settings.maximum_length_name}
  validates :author_name, presence: true,
    length: {maximum: Settings.maximum_length_name}

  validates :price, presence: true
  validates :num_exist, presence: true
  validates :description, presence: true
  validates :picture, presence: true

  scope :create_desc, ->{order(created_at: :desc).limit(Settings.paginate)}
  scope :by_category, (lambda do |id|
    where(category_id: Category.childs_category(id))
  end)
  scope :top_sale, (lambda do
    joins(:order_products).group(:product_id)
      .order(Arel.sql("count(order_products.id) DESC")).limit(Settings.paginate)
  end)
  scope :search, ->(search){where "title like ?", "%#{search}%"}
end
