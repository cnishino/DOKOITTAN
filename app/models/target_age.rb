class TargetAge < ApplicationRecord
  has_many :post_locations, dependent: :destroy
  validates :target, presence: true
end
