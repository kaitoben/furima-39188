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

      it '建物名が空でも購入できる' do
        @order_buyer.building_name = ''
        expect(@order_buyer).to be_valid
      end
    end


    context '商品購入できないとき' do

      it '郵便番号が空だと購入できない' do
        @order_buyer.post_code = ''
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("郵便番号を入力してください")
      end
  
      it '郵便番号はハイフンなしでは購入できない' do
        @order_buyer.post_code = '1111111'
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("郵便番号の入力が正しくありません。ハイフン(-)を入れてください")
      end

      it '都道府県に「---」が選択されている場合は出品できない' do
        @order_buyer.sender_id = 1
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("都道府県を入力してください")
      end

      it '市区町村が空では購入できない' do
        @order_buyer.municipalities = ''
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("市区町村を入力してください")
      end



      it '番地が空では購入できない' do
        @order_buyer.address = ''
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("番地を入力してください")
      end



      it '電話番号が空では購入できない' do
        @order_buyer.phone_number = ''
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("電話番号を入力してください")
      end

      it '電話番号は、10桁より少ないと保存できない' do
        @order_buyer.phone_number = 123456789
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("電話番号の入力が正しくありません。")
      end

      it '電話番号は、11桁より大きいと保存できない' do
        @order_buyer.phone_number = 123456789123
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("電話番号の入力が正しくありません。")
      end

      it '電話番号は、記号を含んでいると保存できない' do
        @order_buyer.phone_number = 123-4567-891
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("電話番号の入力が正しくありません。")
      end

      it '電話番号は、全角数字では保存できない' do
        @order_buyer.phone_number = "１２３４５６７８９１２"
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("電話番号の入力が正しくありません。")
      end

      
      it "userが紐付いていなければ購入できない" do
        @order_buyer.user_id = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("Userを入力してください")
      end

      it "itemが紐付いていなければ購入できない" do
        @order_buyer.item_id = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include ("Itemを入力してください")
      end

      it "tokenが空では登録できないこと" do
        @order_buyer.token = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      
    end
  end


end
