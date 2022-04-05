class Genre < ApplicationRecord
  has_many :post_locations, dependent: :destroy
  validates :genre, presence: true
end
