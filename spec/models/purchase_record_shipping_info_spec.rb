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
      it 'tatemono_nameは空でも保存できること' do
        @purchase_record_shipping_info.tatemono_name = ''
        expect(@purchase_record_shipping_info).to be_valid
      end
      it "tokenがあれば保存ができること" do
        expect(@purchase_record_shipping_info).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @purchase_record_shipping_info.postal_code = ''
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_record_shipping_info.postal_code = '1234567'
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'prefecture_idを選択していないと保存できないこと' do
        @purchase_record_shipping_info.prefecture_id = 1
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'municipalitiesが空だと保存できないこと' do
        @purchase_record_shipping_info.municipalities = ''
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include("Municipalities can't be blank")
      end
      it 'banchiが空だと保存できないこと' do
        @purchase_record_shipping_info.banchi = ''
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include("Banchi can't be blank")
      end
      it 'phoneが空だと保存できないこと' do
        @purchase_record_shipping_info.phone = ''
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include("Phone can't be blank")
      end
      it 'userが紐付いていないと保存できないこと' do
        @purchase_record_shipping_info.user_id = nil
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @purchase_record_shipping_info.item_id = nil
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include("Item can't be blank")
      end
      it "tokenが空では登録できないこと" do
        @purchase_record_shipping_info.token = nil
        @purchase_record_shipping_info.valid?
        expect(@purchase_record_shipping_info.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end