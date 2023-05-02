require 'rails_helper'

RSpec.describe OrderBuyer, type: :model do
 
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_buyer = FactoryBot.build(:order_buyer, user_id: user.id, item_id: item.id) 
  end

  describe '商品購入' do

    context '商品購入できるとき' do
     
      it 'すべて存在すれば購入できる' do
        expect(@order_buyer).to be_valid
       end
    end


    context '商品購入できないとき' do

      it '郵便番号が空だと購入できない' do
        @order_buyer.post_code = ''
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Post code can't be blank")
      end
  
      it '郵便番号はハイフンなしでは購入できない' do
        @order_buyer.post_code = '1111111'
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("Post code is invalid. Include hyphen(-)")
      end

      it '都道府県に「---」が選択されている場合は出品できない' do
        @order_buyer.sender_id = 1
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("Sender can't be blank")
      end

      it '市区町村が空では購入できない' do
        @order_buyer.municipalities = ''
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("Municipalities can't be blank")
      end



      it '番地が空では購入できない' do
        @order_buyer.address = ''
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("Address can't be blank")
      end



      it '電話番号が空では購入できない' do
        @order_buyer.phone_number = ''
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("Phone number can't be blank")
      end

      it '電話番号は、10桁より少ないと保存できない' do
        @order_buyer.phone_number = 123456789
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("Phone number is invalid.")
      end

      it '電話番号は、11桁より大きいと保存できない' do
        @order_buyer.phone_number = 123456789123
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("Phone number is invalid.")
      end

      it '電話番号は、記号を含んでいると保存できない' do
        @order_buyer.phone_number = 123-4567-891
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("Phone number is invalid.")
      end

      it '電話番号は、全角数字では保存できない' do
        @order_buyer.phone_number = "１２３４５６７８９１２"
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("Phone number is invalid.")
      end

      
      it "userが紐付いていなければ購入できない" do
        @order_buyer.user_id = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("User can't be blank")
      end

      it "itemが紐付いていなければ購入できない" do
        @order_buyer.item_id = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("Item can't be blank")
      end

      it "tokenが空では登録できないこと" do
        @order_buyer.token = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Token can't be blank")
      end
      
    end
  end


end
