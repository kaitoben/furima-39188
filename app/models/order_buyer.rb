class OrderBuyer
  include ActiveModel::Model
  attr_accessor :post_code, :sender_id, :municipalities, :address, :building_name, :phone_number, :item_id,  :user_id, :token


  with_options presence: true do
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "の入力が正しくありません。ハイフン(-)を入れてください"}
    validates :municipalities
    validates :address
    validates :phone_number, format: {with: /\A\d{10}\z|\A\d{11}\z/ , message: "の入力が正しくありません。"}
    validates :user_id
    validates :item_id
  end

  validates :token, presence: true

  validates :sender_id, numericality: {  other_than: 1 , message: "を入力してください" } 


  # ここではdonationはorder  addressはbuyer

  def save
    # 商品購入情報を保存し、変数orderに代入する
    order = Order.create(item_id: item_id, user_id: user_id)
    # 住所を保存する
    # donation_idには、変数donationのidと指定する
    Buyer.create(post_code: post_code, sender_id: sender_id, municipalities: municipalities, address: address, building_name: building_name, phone_number: phone_number, order_id: order.id )
  end

end
