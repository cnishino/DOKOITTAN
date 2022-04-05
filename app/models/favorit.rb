class Favorit < ApplicationRecord
  belongs_to :user
  belongs_to :post_location

  validates_uniqueness_of :post_location_id, scope: :user_id

end
