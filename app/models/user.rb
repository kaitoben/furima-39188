class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# ニックネームは入力必須である
  validates :nickname, presence: true

  
# パスワードは半角英数字混合でなければいけない
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角で英字と数字の両方を含めて設定してください' } do
  end


# 苗字と名前は必須で全角文字を使用する必要がある
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'には全角文字を使用してください' } do
    validates :family_name
    validates :first_name
    end
 
# 苗字と名前のカナは必須で全角カタカナで入力する必要がある    
    with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'には全角カタカナを使用してください' } do 
    validates :family_name_kana
    validates :first_name_kana
    end

# 誕生日は入力必須である    
    validates :date_of_birth, presence: true


end
