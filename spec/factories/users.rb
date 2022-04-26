FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation {password}
    surname_zenkaku {"山田"}
    name_zenkaku {"陸太郎"}
    surname_kana {"ヤマダ"}
    name_kana {"リクタロウ"}
    day_of_birth {"1930-01-01"}
  end
end