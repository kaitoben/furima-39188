class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :nickname, presence: true

  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'に全角文字を使用してください' } do
  validates :family_name
  validates :first_name
  end

  with_options presence: true, format: { with: //\A[ァ-ヶー－]+\z/, message: 'に全角カタカナを使用してください' } do 
  validates :family_name_kana
  validates :first_name_kana
  end

  validates :date_of_birth, presence: true

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX }



end
