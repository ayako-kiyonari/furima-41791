FactoryBot.define do
  factory :item do
    item_name                {Faker::Commerce.product_name}
    description              {Faker::Lorem.sentence}
    category_id              {2}
    condition_id             {2}
    deliveryfee_id           {2}
    prefecture_id            {2}
    shipdate_id              {2}
    price                    {500}
    association :user        
    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('public/test.jpg')), filename: 'test.jpg')
    end
  end
end

