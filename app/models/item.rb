class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :region
  belongs_to :duration

  validates :image, presence: true
  validates :title, presence: true
  validates :description, presence: true

  with_options presence: true do
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999},
                      presence: { message: "can't be blank" }
  end

  validates :category_id, numericality: { other_than: 1 , message: "can't be blank" } 
  validates :condition_id, numericality: { other_than: 1 , message: "can't be blank" } 
  validates :postage_id, numericality: { other_than: 1 , message: "can't be blank" } 
  validates :region_id, numericality: { other_than: 1 , message: "can't be blank" } 
  validates :duration_id, numericality: { other_than: 1 , message: "can't be blank" } 

end
