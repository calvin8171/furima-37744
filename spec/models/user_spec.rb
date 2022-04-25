require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '正常に登録できる時' do
      it 'nicknameとemail、passwordとpassword_confirmation、surname_zenkakuとname_zenkaku、surname_kanaとname_kana、day_of_birthが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it "surname_zenkakuが全角文字であれば登録できる" do
        @user.surname_zenkaku = "山田"
        expect(@user).to be_valid
      end
      it "first_nameが全角文字であれば登録できる" do
        @user.name_zenkaku = "陸太郎"
        expect(@user).to be_valid
      end
      it "family_name_kanaが全角カナであれば登録できる" do
        @user.surname_kana = "ヤマダ"
        expect(@user).to be_valid
      end
      it "first_name_kanaが全角カナであれば登録できる" do
        @user.name_kana = "リクタロウ"
        expect(@user).to be_valid
      end
      it "day_of_birthが生年月日であれば登録できる" do
        @user.day_of_birth = "1930-01-01"
        expect(@user).to be_valid
      end
      it "passwordが6文字以上の半角英数字混合であれば登録できる" do
        @user.password = "a1a2a3"
        @user.password_confirmation = "a1a2a3"
        expect(@user).to be_valid
      end
    end
    context '登録ができない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが6文字以下では登録できない' do
        @user.password = 'a1a23'
        @user.password_confirmation = 'a1a2a3'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordが半角英数字混合しないのは登録できない' do
        @user.password = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password has to include both strings and integers")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'a1a2a3'
        @user.password_confirmation = 'a1a2a34'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
