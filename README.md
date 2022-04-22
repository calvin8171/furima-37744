# DB 設計

## users table

| Column             | Type                | Options                   |
|--------------------|---------------------|---------------------------|
| nickname           | string              | null: false               |
| email              | string              | null: false, unique: true |
| encrypted_password | string              | null: false               |
| surname_zenkaku    | string              | null: false               |
| name_zenkaku       | string              | null: false               |
| surname_kana       | string              | null: false               |
| name_kana          | string              | null: false               |
| day_of_birth       | date                | null: false               |

### Association

* has_many :items
* has_many :purchase_records

## items table

| Column                              | Type       | Options                        |
|-------------------------------------|------------|--------------------------------|
| good_name                           | string     | null: false                    |
| good_description                    | text       | null: false                    |
| category_id                         | integer    | null: false                    |
| good_condition_id                   | integer    | null: false                    |
| shipping_fee_payer_id               | integer    | null: false                    |
| shipping_area_id                    | integer    | null: false                    |
| day_to_ship_id                      | integer    | null: false                    |
| price                               | integer    | null: false                    |
| user                                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase_record

## purchase_records table

| Column                              | Type       | Options                        |
|-------------------------------------|------------|--------------------------------|
| user                                | references | null: false, foreign_key: true |
| item                                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_info

## shipping_info table

| Column                              | Type       | Options                        |
|-------------------------------------|------------|--------------------------------|
| postal_code                         | string     | null: false                    |
| prefecture_id                       | integer    | null: false                    |
| municipalities                      | string     | null: false                    |
| banchi                              | string     | null: false                    |
| tatemono_name                       | string     |                                |
| phone                               | integer    | null: false                    |
| purchase_record                     | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase_record