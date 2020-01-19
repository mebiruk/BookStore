class Category < ApplicationRecord
  belongs_to :parent, class_name: Category.name, optional: true
  has_many :childs, class_name: Category.name, foreign_key: :parent_id,
    dependent: :destroy
  has_many :products, dependent: :destroy

  mount_uploader :picture, PictureUploader

  validates :name, presence: true,
    length: {maximum: Settings.maximum_length_name}

  scope :parent_category, ->{where(parent_id: nil)}
  scope :not_parent_category, ->{where.not(parent_id: nil)}
  scope :childs_category, (lambda do |id|
    where("parent_id = ? OR id = ?", id, id).map(&:id)
  end)
end
