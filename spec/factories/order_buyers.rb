FactoryBot.define do
  factory :order_buyer do
    post_code { '123-4567' }
    sender_id { 2 }
    municipalities { '東京都' }
    address { '1-1' }
    building_name { '東京ハイツ' }
    phone_number { 11111111111 }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
