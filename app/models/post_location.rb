class PostLocation < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  validates :user_id, presence:true
  validates :genre_id, presence:true
  validates :prefecture_id, presence:true
  validates :facility_name, presence:true, length: {maximum: 50 }
  validates :target_age, presence:true, length: {minimum: 0, maximum: 18}
  validates :introduction, presence:true, length: {maximum: 200}
  validates :review, presence:true
  validates :is_active, presence:true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @post_location = PostLocation.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @post_location = PostLocation.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @post_location = PostLocation.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @post_location = PostLocation.where("title LIKE?","%#{word}%")
    else
      @post_location = PostLocation.all
    end
  end
end
