class Prefecture < ApplicationRecord
  has_many :post_locations, dependent: :destroy
  validates :prefecture, presence: true
end
