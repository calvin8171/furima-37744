class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :good_condition
  belongs_to :shipping_fee_payer
  belongs_to :shipping_area
  belongs_to :day_to_ship
  has_one_attached :image

  validates :image, presence: true
  validates :good_name, presence: true
  validates :good_description, presence: true
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}  
  validates :good_condition_id, numericality: { other_than: 1 , message: "can't be blank"}  
  validates :shipping_area_id, numericality: { other_than: 1 , message: "can't be blank"}  
  validates :shipping_area_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :day_to_ship_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :price, presence: true
end