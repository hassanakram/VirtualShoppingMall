class Product < ActiveRecord::Base

  PER_PAGE_SIZE = 12
  paginates_per PER_PAGE_SIZE

  attr_accessible :body, :price, :title, :images_attributes

  validates :title, presence: true, length: { maximum: 40 }
  validates :price, presence: true

  has_many :images, as: :imageable, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :images, allow_destroy: true

  scope :ordered, order('created_at DESC')

end
