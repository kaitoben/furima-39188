require 'rails_helper'

RSpec.describe Item, type: :model do
  
  before do
    @item = FactoryBot.build(:item) 
  end

  describe '商品出品' do

    context '商品出品できるとき' do
     
      it 'すべて存在すれば登録できる' do
        expect(@item).to be_valid
       end
    end

    context '商品出品できないとき' do

      it '画像が空だと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
  
      it '商品名が空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include ("Item name can't be blank")
      end

      it '商品の説明が空では登録できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include ("Explanation can't be blank")
      end



      it 'カテゴリーに「---」が選択されている場合は出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include ("Category can't be blank")
      end



      it '商品の状態に「---」が選択されている場合は出品できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include ("Status can't be blank")
      end



      it '配送料の負担に「---」が選択されている場合は出品できない' do
        @item.shipping_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include ("Shipping charge can't be blank")
      end



      it '配送元の地域に「---」が選択されている場合は出品できない' do
        @item.sender_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include ("Sender can't be blank")
      end
      


      it '配送元の地域に「---」が選択されている場合は出品できない' do
        @item.day_to_ship_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include ("Day to ship can't be blank")
      end  

      it '価格が空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include ("Price can't be blank")
      end  


      it '価格が300円より小さいと登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include ("Price must be greater than or equal to 300")
      end


      it '価格が9999999円より大きいと登録できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include ("Price must be less than or equal to 9999999")
      end

      it "価格が半角英字では出品できない" do
        @item.price = "aaaaaaa"
        @item.valid?
        expect(@item.errors.full_messages).to include ("Price is not a number")
      end

      it "価格が全角数字では出品できない" do
        @item.price = "４００"
        @item.valid?
        expect(@item.errors.full_messages).to include ("Price is not a number")
      end

      it "価格が半角英数字混合では出品できない" do
        @item.price = "aaaa1111"
        @item.valid?
        expect(@item.errors.full_messages).to include ("Price is not a number")
      end

      it "userが紐付いていなければ出品できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include ("User must exist")
      end
      
    end
  end
end
