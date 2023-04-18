#　テーブル設計

## usersテーブル

| Column             | Type      | Option       |
| ------------------ | --------- | ------------ |
| nickname           | string    | null: false  |
| email              | string    | unique: true |
| encrypted_password | string    | null: false  |
| family_name        | string    | null: false  |
| first_name         | string    | null: false  |
| family_name_kana   | string    | null: false  |
| first_name_kana    | string    | null: false  |
| date_of_birth      | date      | null: false  |

- has_many :items
- has_many :orders


## ordersテーブル
| Column         | Type       | Option             |
| -------------- | ---------- | ------------------ |
| item           | references | foreign_key: true  |
| user           | references | foreign_key: true  |

- belongs_to :user
- belongs_to :item
- has_many  :buyers


## buyersテーブル
| Column         | Type       | Option             |
| -------------- | ---------- | ------------------ |
| post_code      | string     | null: false        | 
| sender_id      | integer    | null: false        |
| municipalities | string     | null: false        |
| address        | string     | null: false        |
| building_name  | string     |                    |
| phone_number   | string     | null: false        |
| order          | references | foreign_key: true  |

- belongs_to :order


## itemsテーブル

| Column              | Type       | Option            |
| ------------------- | ---------- | ----------------- |
| item_name           | string     | null: false       |
| explanation         | text       | null: false       |
| category_id         | integer    | null: false       |
| status_id           | integer    | null: false       |
| shipping_charges_id | integer    | null: false       |
| sender_id           | integer    | null: false       |
| days_to_ship_id     | integer    | null: false       |
| price               | integer    | null: false       |
| user                | references | foreign_key: true |

- has_one    :order
- belongs_to :user

