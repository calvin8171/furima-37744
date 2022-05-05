class CreatePurchaseRecordShippingInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_record_shipping_infos do |t|

      t.timestamps
    end
  end
end
