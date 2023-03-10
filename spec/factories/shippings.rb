FactoryBot.define do
  factory :shipping do
    association :order
  end
end
