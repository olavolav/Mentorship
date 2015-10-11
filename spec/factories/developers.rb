FactoryGirl.define do
  factory :developer do
    name 'Steve Ballmer'
    starting_date Time.new(1975, 4, 4)
    image_url 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Steve_Ballmer_at_CES_2010_cropped.jpg/170px-Steve_Ballmer_at_CES_2010_cropped.jpg'
  end
end
