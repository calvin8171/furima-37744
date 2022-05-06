FactoryBot.define do
  factory :purchase_record_shipping_info do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    municipalities { '東京都' }
    banchi { '1-2-3' }
    tatemono_name { '東京ハイツ' }
    phone { '08012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end

