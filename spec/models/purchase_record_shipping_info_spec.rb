require 'rails_helper'

RSpec.describe PurchaseRecordShippingInfo, type: :model do
  describe '購入内容の確認' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_record_shipping_info = FactoryBot.build(:purchase_record_shipping_info, user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_record_shipping_info).to be_valid
      end
      it '建物名は空でも保存できること' do
        @purchase_record_shipping_info.tatemono_name = ''
        expect(@purchase_record_shipping_info).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空だと保存できないこと' do
        @purchase_record_shipping_info.postal_code = ''
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include("郵便番号を入力してください")
      end
      it '郵便番号が半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_record_shipping_info.postal_code = '1234567'
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include('郵便番号は無効です、ハイフン（-）を含めてください')
      end
      it '都道府県を選択していないと保存できないこと' do
        @purchase_record_shipping_info.prefecture_id = 1
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include("都道府県を選択してください")
      end
      it '市区町村が空だと保存できないこと' do
        @purchase_record_shipping_info.municipalities = ''
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include("市区町村を入力してください")
      end
      it '番地が空だと保存できないこと' do
        @purchase_record_shipping_info.banchi = ''
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が空だと保存できないこと' do
        @purchase_record_shipping_info.phone = ''
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include("電話番号を入力してください")
      end
      it '電話番号が9桁以下では購入できない' do
        @purchase_record_shipping_info.phone = '123456789'
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include("電話番号を10桁または11桁の半角数字で入力してください")
      end
      it '電話番号が12桁以上では購入できない' do
        @purchase_record_shipping_info.phone = '123456789012'
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include("電話番号を10桁または11桁の半角数字で入力してください")
      end
      it '電話番号に半角数字以外が含まれている場合は購入できない' do
        @purchase_record_shipping_info.phone = '０８０１２３４５６７８'
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include("電話番号を10桁または11桁の半角数字で入力してください")
      end
      it 'userが紐付いていないと保存できないこと' do
        @purchase_record_shipping_info.user_id = nil
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include("Userを入力してください")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @purchase_record_shipping_info.item_id = nil
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include("Itemを入力してください")
      end
      it "tokenが空では登録できないこと" do
        @purchase_record_shipping_info.token = nil
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
    end
  end
end