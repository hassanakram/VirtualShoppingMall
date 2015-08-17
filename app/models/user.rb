class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :image_attributes

  has_one :image, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :image

  def fetch_image
    self.image.present? ? self.image : self.build_image
  end

end
