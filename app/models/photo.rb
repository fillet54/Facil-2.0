class Photo < ActiveRecord::Base
  attr_accessible :name, :description

  belongs_to :album
end
