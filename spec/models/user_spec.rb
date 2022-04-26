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
      it "name_zenkakuが全角文字であれば登録できる" do
        @user.name_zenkaku = "陸太郎"
        expect(@user).to be_valid
      end
      it "surname_kanaが全角カナであれば登録できる" do
        @user.surname_kana = "ヤマダ"
        expect(@user).to be_valid
      end
      it "name_kanaが全角カナであれば登録できる" do
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
      it 'passwordが半角英数字混合しないと登録できない' do
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
      it 'passwordが全角文字では登録できないこと' do
        @user.password = 'アイウエオ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password has to include both strings and integers")
      end
      it 'passwordが半角数字では登録できないこと' do
        @user.password = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password has to include both strings and integers")
      end  
      it 'passwordが半角英語だけでは登録できないこと' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password has to include both strings and integers")
      end
      it 'surname zenkaku が空だと登録できない' do
        @user.surname_zenkaku = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Surname zenkaku can't be blank")
      end 
      it 'surname zenkaku に半角文字が含まれていると登録できない' do
        @user.surname_zenkaku = 'ｱｲｳｴｵ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Surname zenkaku is invalid")
      end
      it 'name zenkaku が空だと登録できない' do
        @user.name_zenkaku = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name zenkaku can't be blank")
      end 
      it 'name zenkaku に半角文字が含まれていると登録できない' do
        @user.name_zenkaku = 'ｱｲｳｴｵ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name zenkaku is invalid")
      end
      it 'surname kana が空だと登録できない' do
        @user.surname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Surname kana can't be blank")
      end
      it 'surname kana にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
        @user.surname_kana = 'kana'
        @user.valid?
        expect(@user.errors.full_messages).to include("Surname kana is invalid")
      end
      it 'name kana が空だと登録できない' do
        @user.name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana can't be blank")
      end
      it 'name kana にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
        @user.name_kana = 'kana'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana is invalid")
      end
      it 'day of birth が空だと登録できない' do
        @user.day_of_birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Day of birth can't be blank")
      end   
    end
  end
end
