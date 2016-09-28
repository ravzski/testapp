class Product < ApplicationRecord

  belongs_to :category
  
  validates :name,:price,:category, presence: true
end
