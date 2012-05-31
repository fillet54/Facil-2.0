class Photo < ActiveRecord::Base
  attr_accessible :name, :description, :image
  belongs_to :album
  mount_uploader :image, PhotoUploader
  validates :image, presence: true
end
