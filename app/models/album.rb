class Album < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :photos

  validates :name, presence: true, length: { maximum: 50 }
end
