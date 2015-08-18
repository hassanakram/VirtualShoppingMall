class Review < ActiveRecord::Base

  attr_accessible :review

  belongs_to :product

end
