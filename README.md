# DB 設計

## users table

| Column             | Type                | Options                   |
|--------------------|---------------------|---------------------------|
| nickname           | string              | null: false               |
| email              | string              | null: false, unique: true |
| encrypted_password | string              | null: false               |
| name_zenkaku       | string              | null: false               |
| name_kana          | text                | null: false               |
| day_of_birth       | text                | null: false               |

### Association

* has_many :items
* has_many :purchase_records

## items table

| Column                              | Type       | Options                        |
|-------------------------------------|------------|--------------------------------|
| good_name                           | string     | null: false                    |
| good_description                    | text       | null: false                    |
| category                            | string     | null: false                    |
| good_condition                      | string     | null: false                    |
| shipping_fee_payer                  | string     | null: false                    |
| shipping_area                       | string     | null: false                    |
| day_to_ship                         | string     | null: false                    |
| day_to_ship                         | string     | null: false                    |
| user                                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase_record
- has_one :shipping_info

## purchase_records table

| Column                              | Type       | Options                        |
|-------------------------------------|------------|--------------------------------|
| credit_card_no                      | string     | null: false                    |
| validation_day                      | string     | null: false                    |
| security_code                       | string     | null: false                    |
| user                                | references | null: false, foreign_key: true |
| item                                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## shipping_info table

| Column                              | Type       | Options                        |
|-------------------------------------|------------|--------------------------------|
| postal_code                         | string     | null: false                    |
| prefecture                          | string     | null: false                    |
| municipalities                      | string     | null: false                    |
| banchi                              | string     | null: false                    |
| building                            | string     | null: false                    |
| phone                               | string     | null: false                    |
| item                                | references | null: false, foreign_key: true |

### Association

- belongs_to :item