class User < ApplicationRecord
  devise :database_authenticatable, :confirmable, :registerable,
    :recoverable, :rememberable, :validatable
  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
  before_save :downcase_email
  enum role: {customer: 0, admin: 1}
  validates :name, presence: true,
    length: {maximum: Settings.maximum_length_name}
  validates :address, length: {maximum: Settings.maximum_length_address}
  validates :phone, length: {maximum: Settings.maximum_length_phone}

  private

  def downcase_email
    email.downcase!
  end
end
