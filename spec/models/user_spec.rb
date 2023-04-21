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
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end

    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it 'emailに一意性がある' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'emailは@を含む必要がある' do
      @user.email = 'testmail'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'パスワードが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'パスワードは６文字以上の入力が必須' do
      @user.password = '00000'
      @user.password_confirmation = '00000'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it '数字のみのパスワードでは登録できない' do
      @user.password = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password は半角で英字と数字の両方を含めて設定してください")
    end

    it '英字のみのパスワードでは登録できない' do
      @user.password = 'abcdefg'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password は半角で英字と数字の両方を含めて設定してください")
    end

    it '全角文字を含むパスワードは登録できない' do
      @user.password = 'abcあ1234'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password は半角で英字と数字の両方を含めて設定してください")
    end


    it 'パスワードとその確認の値は一致している必要がある' do
      @user.password = '123456'
      @user.password_confirmation = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it '性の入力は必須である' do
      @user.family_name = ''
      @user.valid? 
      expect(@user.errors.full_messages).to include("Family name can't be blank")
    end

    it '名の入力は必須である' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it '性（カナ）の入力は必須である' do
      @user.family_name_kana = ''
      @user.valid? 
      expect(@user.errors.full_messages).to include("Family name kana can't be blank")
    end

    it '名（カナ）の入力は必須である' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end


    it '性の入力は全角での入力が必須である' do
      @user.family_name = 'あああaaaあああ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name には全角文字を使用してください")
    end

    it '名の入力は全角での入力が必須である' do
      @user.first_name = 'あああaaaあああ'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name には全角文字を使用してください")
    end


    it '性(カナ)にに平仮名が含まれていると登録できない' do
      @user.family_name_kana = 'あいうアイウ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana には全角カタカナを使用してください")
    end

    it '性(カナ)に漢字が含まれていると登録できない' do
      @user.family_name_kana = '阿意得アイウ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana には全角カタカナを使用してください")
    end

    it '性(カナ)にに英字が含まれていると登録できない' do
      @user.family_name_kana = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana には全角カタカナを使用してください")
    end

    it '性(カナ)にに数字が含まれていると登録できない' do
      @user.family_name_kana = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana には全角カタカナを使用してください")
    end
    it '性(カナ)に記号が含まれていると登録できない' do
      @user.family_name_kana = 'アイウ＠＄％'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana には全角カタカナを使用してください")
    end

    it '名(カナ)にに平仮名が含まれていると登録できない' do
      @user.first_name_kana = 'あいうアイウ'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana には全角カタカナを使用してください")
    end

    it '名(カナ)に漢字が含まれていると登録できない' do
      @user.first_name_kana = '阿意得アイウ'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana には全角カタカナを使用してください")
    end

    it '名(カナ)にに英字が含まれていると登録できない' do
      @user.first_name_kana = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana には全角カタカナを使用してください")
    end

    it '名(カナ)にに数字が含まれていると登録できない' do
      @user.first_name_kana = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana には全角カタカナを使用してください")
    end
    it '名(カナ)に記号が含まれていると登録できない' do
      @user.first_name_kana = 'アイウ＠＄％'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana には全角カタカナを使用してください")
    end

    it '誕生日の入力は必須である' do
      @user.date_of_birth = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Date of birth can't be blank")
    end
  end

 end
end
