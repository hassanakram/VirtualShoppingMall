class Product < ActiveRecord::Base

  attr_accessible :body, :price, :title, :images_attributes

  has_many :images, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :images, :allow_destroy => true

end
