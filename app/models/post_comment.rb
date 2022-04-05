class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post_location
  validates :comment, presence:true
end
