FactoryBot.define do
  factory :item do
    good_name {"商品名"}
    good_description {"商品の説明"}
    category_id {2}
    good_condition_id {2}
    shipping_fee_payer_id {2}
    shipping_area_id {2}
    day_to_ship_id {2}
    price {3333}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
