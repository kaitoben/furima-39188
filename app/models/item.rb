class Item < ApplicationRecord

belongs_to :user
has_one_attached :image

extend ActiveHash::Associations::ActiveRecordExtensions
belongs_to :category
belongs_to :status
belongs_to :shipping_charge
belongs_to :sender
belongs_to :day_to_ship

validates :item_name, presence: true
validates :explanation, presence: true


validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                  format: { with: /\A[0-9]+\z/ }

validates :image, presence: true


validates :category_id, numericality: {  other_than: 1 , message: "can't be blank" } 
validates :status_id, numericality: {  other_than: 1 , message: "can't be blank" } 
validates :shipping_charge_id, numericality: {  other_than: 1 , message: "can't be blank" } 
validates :sender_id, numericality: {  other_than: 1 , message: "can't be blank" } 
validates :day_to_ship_id, numericality: {  other_than: 1 , message: "can't be blank" } 


end
