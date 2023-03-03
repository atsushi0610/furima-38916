FactoryBot.define do
  factory :user do
    
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)}
    password_confirmation {password}

    gimei = Gimei.name

    last_name             {gimei.last}
    first_name            {gimei.first}
    last_name_kana        {gimei.last.katakana}
    first_name_kana       {gimei.first.katakana}
    birth_date            {Faker::Date.birthday}
  end
end