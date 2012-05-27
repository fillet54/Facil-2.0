ENV["RAILS_ENV"] ||= 'development'
require File.expand_path("../../config/environment", __FILE__)

# puts Album.count
# 
# 
# album = Album.create(name: "Created from CMD", description: "This was created from command line") 
# puts Album.count
# 
# photo = album.photos.new
# photo.name = "Rails.png"
# photo.description = "New Photo"
# photo.image = File.open("#{Rails.root}/spec/support/photos/images/rails.png")
# photo.save
