FactoryBot.define do
  factory :item do

    item_name             {"本"}
    explanation           {"商品の説明"}
    category_id           {2}
    status_id             {2}
    shipping_charge_id    {2}
    sender_id             {2}
    day_to_ship_id        {2}
    price                 {10000}

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end



    association :user

  end
end
