FactoryBot.define do
  factory :order_shipping do
    post_code { '123-4567' }
    region_id { 2 }
    city { '東京都' }
    block { '1-1' }
    building { '東京ハイツ' }
    phone_number { '09012345678' }
    association :user
    association :item
  end
end
