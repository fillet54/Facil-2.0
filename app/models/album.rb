class Album < ActiveRecord::Base
  attr_accessible :name, :description, :image_url

  has_many :photos, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }

  def image_url
    if photos.empty?
      "http://placehold.it/260x260"
    else
      photos.first.image_url(:thumb).to_s
    end
  end
end
