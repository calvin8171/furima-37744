class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :items
  has_many :purchase_records
  
  validates :nickname, presence: true
  validates :surname_zenkaku, presence: true, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
  validates :name_zenkaku, presence: true, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
  validates :surname_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/ }
  validates :name_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/ }
  validates :day_of_birth, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は半角英数字を含めてください'
end