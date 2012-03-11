FactoryGirl.define do
  factory :album do
    sequence(:name) { |n| "Album #{n}" }
    sequence(:description) { |n| "This is the album #{n} description" }
  end

  factory :photo do
    sequence(:name) { |n| "Image #{n}" }
    sequence(:description) { |n| "Image #{n} description" }
    sequence(:path) { |n| "image_#{n}_path" }

    album
  end
end
