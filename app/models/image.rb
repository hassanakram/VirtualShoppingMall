class Image < ActiveRecord::Base

  belongs_to :imageable, polymorphic: true

  attr_accessible :photo

  has_attached_file :photo, styles: { medium: "500x500>", thumb: "100x100>" }

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

end
