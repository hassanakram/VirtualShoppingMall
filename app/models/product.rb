class Product < ActiveRecord::Base

  PER_PAGE_SIZE = 20
  paginates_per PER_PAGE_SIZE

  attr_accessible :body, :price, :title, :images_attributes

  has_many :images, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :images, :allow_destroy => true

  scope :ordered, order('created_at DESC')

end
