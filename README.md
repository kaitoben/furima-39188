#　テーブル設計

## usersテーブル

| Column          | Type      | Option     |
| --------------- | --------- | ---------- |
| nickname        | string    | not null   |
| mail_address    | string    | not null   |
| password        | string    | not null   |
| name            | string    | not null   |
| name_kana       | string    | not null   |
| date_of_birth   | string    | not null   |


- has_many :orders
- has_many :items


## ordersテーブル

| Column         | Type       | Option   |
| -------------- | ---------- | -------- |
| cash_number    | string     | not null |
| effective date | string     | not null |
| security_code  | string     | not null |
| post_code      | string     | not null |    
| prefecture     | string     | not null |
| municipalities | string     | not null |
| address        | string     | not null |
| building_name  | string     | not null |


- belongs_to :users
- belongs_to :items

## itemsテーブル

| Column           | Type       | Option   |
| ---------------- | ---------- | -------- |
| item_name        | text       | not null |
| explanation      | references | not null |
| category         | references | not null |
| status           | string     | not null |
| shipping_charges | string     | not null |
| sender           | string     | not null |
| days_to_ship     | string     | not null |




- belongs_to :users
- belongs_to :orders
