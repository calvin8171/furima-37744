class CreateShippingInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_infos do |t|
      t.string :postal_code, null: false
      t.integer :prefecture_id, null: false
      t.string :municipalities , null: false
      t.string :banchi, null: false
      t.string :tatemono_name
      t.string :phone, null: false
      t.references :purchase_record, null: false, foreign_key: true
      t.timestamps
    end
  end
end
