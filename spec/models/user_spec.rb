require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '正常に登録できる時' do
      it 'ニックネームとEメール、パスワード（確認用）とパスワード、姓(全角)と名前(全角)、姓(カナ)と名前(カナ)、 生年月日が存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it "姓(全角)が全角文字であれば登録できる" do
        @user.surname_zenkaku = "山田"
        expect(@user).to be_valid
      end
      it "名前(全角)が全角文字であれば登録できる" do
        @user.name_zenkaku = "陸太郎"
        expect(@user).to be_valid
      end
      it "姓(カナ)が全角カナであれば登録できる" do
        @user.surname_kana = "ヤマダ"
        expect(@user).to be_valid
      end
      it "名前(カナ)が全角カナであれば登録できる" do
        @user.name_kana = "リクタロウ"
        expect(@user).to be_valid
      end
      it "生年月日が生年月日であれば登録できる" do
        @user.day_of_birth = "1930-01-01"
        expect(@user).to be_valid
      end
      it "パスワードが6文字以上の半角英数字混合であれば登録できる" do
        @user.password = "a1a2a3"
        @user.password_confirmation = "a1a2a3"
        expect(@user).to be_valid
      end
    end
    context '登録ができない時' do
      it 'ニックネームが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'Eメールが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it '重複したEメールが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it 'Eメールは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'パスワードが6文字以下では登録できない' do
        @user.password = 'a1a23'
        @user.password_confirmation = 'a1a2a3'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it 'パスワードが半角英数字混合しないと登録できない' do
        @user.password = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字を含めてください")
      end
      it 'パスワードとパスワード（確認用）が不一致では登録できない' do
        @user.password = 'a1a2a3'
        @user.password_confirmation = 'a1a2a34'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'パスワードが全角文字では登録できないこと' do
        @user.password = 'アイウエオ'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字を含めてください")
      end
      it 'パスワードが半角数字では登録できないこと' do
        @user.password = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字を含めてください")
      end  
      it 'パスワードが半角英語だけでは登録できないこと' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字を含めてください")
      end
      it '姓(全角)が空だと登録できない' do
        @user.surname_zenkaku = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("姓(全角)を入力してください")
      end 
      it '姓(全角)に半角文字が含まれていると登録できない' do
        @user.surname_zenkaku = 'ｱｲｳｴｵ'
        @user.valid?
        expect(@user.errors.full_messages).to include("姓(全角)は不正な値です")
      end
      it '名前(全角)が空だと登録できない' do
        @user.name_zenkaku = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(全角)を入力してください")
      end 
      it '名前(全角に半角文字が含まれていると登録できない' do
        @user.name_zenkaku = 'ｱｲｳｴｵ'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(全角)は不正な値です")
      end
      it '姓(カナ)が空だと登録できない' do
        @user.surname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("姓(カナ)を入力してください")
      end
      it '姓(カナ)にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
        @user.surname_kana = 'kana'
        @user.valid?
        expect(@user.errors.full_messages).to include("姓(カナ)は不正な値です")
      end
      it '名前(カナ)が空だと登録できない' do
        @user.name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)を入力してください")
      end
      it '名前(カナ)にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
        @user.name_kana = 'kana'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)は不正な値です")
      end
      it '生年月日が空だと登録できない' do
        @user.day_of_birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end   
    end
  end
end
