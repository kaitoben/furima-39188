#　テーブル設計

## usersテーブル

| Column             | Type      | Option     |
| ------------------ | --------- | ---------- |
| nickname           | string    | not null   |
| email              | string    | unique     |
| encrypted_password | string    | not null   |
| family_name        | string    | not null   |
| first_name         | string    | not null   |
| family_name_kana   | string    | not null   |
| first_name_kana    | string    | not null   |
| date_of_birth      | date      | not null   |

- has_many :items


## ordersテーブル
| Column         | Type       | Option   |
| -------------- | ---------- | -------- |
| item_id        | references | not null |
| user_id        | references | not null |

- belong_to :users
- belong_to :items
- belong_to :buyers


## buyersテーブル
| Column         | Type       | Option   |
| -------------- | ---------- | -------- |
| post_code      | string     | not null |    
| prefecture     | string     | not null |
| municipalities | string     | not null |
| address        | string     | not null |
| building_name  | string     | not null |
| user_id        | references | not null |

- belongs_to :items
- has_many   :orders

## itemsテーブル

| Column              | Type       | Option   |
| ------------------- | ---------- | -------- |
| item_name           | string     | not null |
| explanation         | text       | not null |
| category_id         | integer    | not null |
| status_id           | integer    | not null |
| shipping_charges_id | integer    | not null |
| sender_id           | integer    | not null |
| days_to_ship_id     | integer    | not null |
| price               | integer    | not null |
| user_id             | references | not null |

- has-one    :buyers
- has-one    :orders
- belongs_to :users

