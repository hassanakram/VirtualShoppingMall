class Review < ActiveRecord::Base

  PER_PAGE_SIZE = 20
  paginates_per PER_PAGE_SIZE

  attr_accessible :review

  validates :review, presence: true

  belongs_to :product
  belongs_to :user

  scope :ordered, order('created_at DESC')

end
