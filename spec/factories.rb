FactoryGirl.define do
  factory :album do
    sequence(:name) { |n| "Album #{n}" }
    sequence(:description) { |n| "This is the album #{n} description" }
  end

  factory :photo do
    name "Image 1"
    description "Image 1 description"
    path "the/image/path"

    album
  end
end
