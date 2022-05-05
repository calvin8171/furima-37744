class PurchaseRecord < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :item
  belongs_to :Prefecture
  has_one :shipping_info
end
