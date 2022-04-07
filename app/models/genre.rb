class Genre < ApplicationRecord
  has_many :post_locations, dependent: :destroy
  validates :name, presence: true
end
