FactoryGirl.define do
  factory :album do
    name "Album 1"
    description "This is the album 1 description"
  end

  factory :photo do
    path "the/image/path"
    album
  end
end
