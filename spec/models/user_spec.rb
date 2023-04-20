require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user) 
  end
  

  describe 'ユーザー新規登録' do

    it 'すべて存在すれば登録できる' do
      expect(@user).to be_valid
    end

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

    it 'パスワードは半角英数字混合の入力が必須' do
      @user.password = '1234567'
      @user.valid?
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


    it 'お名前の入力は全角での入力が必須である' do
      @user.first_name = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name に全角文字を使用してください")
    end


    it 'お名前(カナ)は全角カタカナの入力が必須である' do
      @user.first_name_kana = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana に全角カタカナを使用してください")

    end




  end
end
