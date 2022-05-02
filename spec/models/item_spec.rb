require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品情報入力' do
    context '商品情報入力がうまくい行ける時' do
      it '全ての値が正しく入力されていれば出品できること' do
        expect(@item).to be_valid
      end
    end
    context '商品情報の入力がうまく行かない時' do
      it 'imageが空だと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'good_nameが空だと出品できない' do
        @item.good_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Good name can't be blank")
      end
      it 'good_descriptionが空だと出品できない' do
        @item.good_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Good description can't be blank")
      end
      it 'categoryが未選択だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'good conditionが未選択だと出品できない' do
        @item.good_condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Good condition can't be blank")
      end
      it 'shipping fee payerが未選択だと出品できない' do
        @item.shipping_fee_payer_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee payer can't be blank")
      end
      it 'shipping areaが未選択だと出品できない' do
        @item.shipping_area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping area can't be blank")
      end
      it 'day to shipが未選択だと出品できない' do
        @item.day_to_ship_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Day to ship can't be blank")
      end
      it 'priceが空だと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price needs to be half-width number")
      end
      it 'priceが全角数字だと出品できない' do
        @item.price = "２０００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price needs to be half-width number")
      end
      it 'priceが¥300以下だと出品できない' do
        @item.price = "299"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of range")
      end
      it 'priceが¥9999999以上だと出品できない' do
        @item.price = "10_000_000"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of range")
      end
      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end

