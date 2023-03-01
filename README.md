## usersテーブル

| Column             | Type                     | Options                   |
| ------------------ | ------------------------ | ------------------------- |
| nickname           | string                   | null: false               |
| email              | string                   | null: false, unique: true |
| encrypted_password | string                   | null: false               |
| last_name          | string                   | null: false               |
| first_name         | string                   | null: false               |
| last_name_kana     | references               | null: false               |
| first_name_kana    | string                   | null: false               |
| birth_year         | integer                  | null: false               | 
| birth_month        | integer                  | null: false               |
| birth_day          | integer                  | null: false               |

### Association
- has_many :items
- has-many :orders


## itemsテーブル

| Column      | Type       | Options                        |
| ------------| -----------| ------------------------------ |
| title       | string     | null: false                    |
| description | text       | null: false                    |
| category    | integer    | null: false                    |
| condition   | integer    | null: false                    |
| postage     | integer    | null: false                    |
| region      | integer    | null: false                    |
| duration    | integer    | null: false                    |
| price       | integer    | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has-one :order


## ordersテーブル

| Column | Type       | Options                        |
| ------ | -----------| ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item


## shippingsテーブル

| Column       | Type       | Options                        |
| -------------| -----------| ------------------------------ |
| post_code    | integer    | null: false                    |
| prefectures  | integer    | null: false                    |
| city         | string     | null: false                    |
| block        | string     | null: false                    |
| building     | string     |                                |
| phone_number | integer    | null: false                    |
| order        | references | null: false, foreign_key: true |

### Association
- belongs_to :order
