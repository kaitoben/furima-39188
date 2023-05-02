class Buyer < ApplicationRecord

  belongs_to :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :sender
  
end
