class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :image_attributes, :first_name, :last_name

  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }

  has_one :image, as: :imageable, dependent: :destroy
  has_many :products
  has_many :reviews

  accepts_nested_attributes_for :image

  def fetch_image
    self.image.present? ? self.image : self.build_image
  end

  def is_owner?(user_id)
    self.id == user_id
  end
end
