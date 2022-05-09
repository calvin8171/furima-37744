class PurchaseRecordShippingInfo 
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :municipalities, :banchi, :tatemono_name, :phone, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "は無効です、ハイフン（-）を含めてください"}
    validates :municipalities
    validates :banchi
    validates :phone, format: {with: /\A\d{10,11}\z/, message: "を10桁または11桁の半角数字で入力してください" } 
    validates :token
  end
  validates :prefecture_id, numericality: {other_than: 1, message: "を選択してください" }

  def save
    purchase_record = PurchaseRecord.create(user_id: user_id, item_id: item_id)
    # 住所を保存する
    ShippingInfo.create(postal_code: postal_code, prefecture_id: prefecture_id, municipalities: municipalities, banchi: banchi, tatemono_name: tatemono_name, phone: phone, purchase_record_id: purchase_record.id)
  end
end
