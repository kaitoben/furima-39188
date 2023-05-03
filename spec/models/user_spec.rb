require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user) 
  end
  

 describe 'ユーザー新規登録' do
  context '新規登録できるとき' do
     
      it 'すべて存在すれば登録できる' do
        expect(@user).to be_valid
       end
  end
    
  context '新規登録できないとき' do

    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "ニックネームを入力してください"
    end

    it 'emailが空では登録できない' do
      @user.email = ''  
      @user.valid?
      expect(@user.errors.full_messages).to include "Eメールを入力してください"
    end

    it 'emailに一意性がある' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end

    it 'emailは@を含む必要がある' do
      @user.email = 'testmail'
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールは不正な値です')
    end

    it 'パスワードが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください")
    end

    it 'パスワードは６文字以上の入力が必須' do
      @user.password = '00000'
      @user.password_confirmation = '00000'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end

    it '数字のみのパスワードでは登録できない' do
      @user.password = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは半角で英字と数字の両方を含めて設定してください")
    end

    it '英字のみのパスワードでは登録できない' do
      @user.password = 'abcdefg'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは半角で英字と数字の両方を含めて設定してください")
    end

    it '全角文字を含むパスワードは登録できない' do
      @user.password = 'abcあ1234'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは半角で英字と数字の両方を含めて設定してください")
    end


    it 'パスワードとその確認の値は一致している必要がある' do
      @user.password = '123456'
      @user.password_confirmation = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end

    it '性の入力は必須である' do
      @user.family_name = ''
      @user.valid? 
      expect(@user.errors.full_messages).to include("お名前(姓)を入力してください")
    end

    it '名の入力は必須である' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前(名)を入力してください")
    end

    it '性（カナ）の入力は必須である' do
      @user.family_name_kana = ''
      @user.valid? 
      expect(@user.errors.full_messages).to include("お名前カナ(姓)を入力してください")
    end

    it '名（カナ）の入力は必須である' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前カナ(名)を入力してください")
    end


    it '性の入力は全角での入力が必須である' do
      @user.family_name = 'あああaaaあああ'
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前(姓)には全角文字を使用してください")
    end

    it '名の入力は全角での入力が必須である' do
      @user.first_name = 'あああaaaあああ'
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前(名)には全角文字を使用してください")
    end


    it '性(カナ)にに平仮名が含まれていると登録できない' do
      @user.family_name_kana = 'あいうアイウ'
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前カナ(姓)には全角カタカナを使用してください")
    end

    it '性(カナ)に漢字が含まれていると登録できない' do
      @user.family_name_kana = '阿意得アイウ'
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前カナ(姓)には全角カタカナを使用してください")
    end

    it '性(カナ)にに英字が含まれていると登録できない' do
      @user.family_name_kana = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前カナ(姓)には全角カタカナを使用してください")
    end

    it '性(カナ)にに数字が含まれていると登録できない' do
      @user.family_name_kana = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前カナ(姓)には全角カタカナを使用してください")
    end
    it '性(カナ)に記号が含まれていると登録できない' do
      @user.family_name_kana = 'アイウ＠＄％'
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前カナ(姓)には全角カタカナを使用してください")
    end

    it '名(カナ)にに平仮名が含まれていると登録できない' do
      @user.first_name_kana = 'あいうアイウ'
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前カナ(名)には全角カタカナを使用してください")
    end

    it '名(カナ)に漢字が含まれていると登録できない' do
      @user.first_name_kana = '阿意得アイウ'
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前カナ(名)には全角カタカナを使用してください")
    end

    it '名(カナ)にに英字が含まれていると登録できない' do
      @user.first_name_kana = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前カナ(名)には全角カタカナを使用してください")
    end

    it '名(カナ)にに数字が含まれていると登録できない' do
      @user.first_name_kana = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前カナ(名)には全角カタカナを使用してください")
    end
    it '名(カナ)に記号が含まれていると登録できない' do
      @user.first_name_kana = 'アイウ＠＄％'
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前カナ(名)には全角カタカナを使用してください")
    end

    it '誕生日の入力は必須である' do
      @user.date_of_birth = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("生年月日を入力してください")
    end
  end

 end
end
