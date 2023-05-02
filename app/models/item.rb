class Item < ApplicationRecord

has_one    :order
belongs_to :user
has_one_attached :image

# 画像が空では登録できない
validates :image, presence: true

# 商品名が空では登録できない
validates :item_name, presence: true

# 商品の説明が空では登録できない
validates :explanation, presence: true

# 価格は空では登録できない
validates :price, presence: true

# 価格は半角数値で300円以上、9999999円以下でなければ登録できない
validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
                  


extend ActiveHash::Associations::ActiveRecordExtensions
belongs_to :category
belongs_to :status
belongs_to :shipping_charge
belongs_to :sender
belongs_to :day_to_ship

# idが1、すなわち空欄では登録できない
validates :category_id, numericality: {  other_than: 1 , message: "can't be blank" } 
validates :status_id, numericality: {  other_than: 1 , message: "can't be blank" } 
validates :shipping_charge_id, numericality: {  other_than: 1 , message: "can't be blank" } 
validates :sender_id, numericality: {  other_than: 1 , message: "can't be blank" } 
validates :day_to_ship_id, numericality: {  other_than: 1 , message: "can't be blank" } 


end
