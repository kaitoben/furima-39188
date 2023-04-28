class Buyer < ApplicationRecord
  belongs_to :order
  belongs_to :sender
end
