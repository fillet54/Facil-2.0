FactoryGirl.define do
  factory :album do
    sequence(:name) { |n| "Album #{n}" }
    sequence(:description) { |n| "This is the album #{n} description" }
  end

  factory :photo do
    sequence(:name) { |n| "Image #{n}" }
    sequence(:description) { |n| "Image #{n} description" }
    image { File.open(File.join(Rails.root, 'spec', 'support', 'photos', 'images', 'rails.png')) }

    album
  end
end
