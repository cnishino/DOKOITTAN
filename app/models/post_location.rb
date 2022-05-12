class PostLocation < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  belongs_to :target_age
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy


  has_one_attached :post_image #アクティブストレージで投稿画像表示

  validates :user_id, presence:true
  validates :genre_id, presence:true
  validates :prefecture, presence:true
  validates :facility_name, presence:true, length: {maximum: 50 }
  validates :target_age_id, presence:true
  validates :introduction, presence:true, length: {maximum: 200}
  validates :post_image, presence:true
  # validates :is_active, presence:true

  def favorited_by?(user) #いいねしているかの判定
   favorites.where(user_id: user.id).exists?
  end

#一覧画面並び替え用
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(star: :desc)}

#都道府県登録用
  enum prefecture:{
     北海道:0,青森県:1,岩手県:2,宮城県:3,秋田県:4,山形県:5,福島県:6,
     茨城県:7,栃木県:8,群馬県:9,埼玉県:10,千葉県:11,東京都:12,神奈川県:13,
     新潟県:14,富山県:15,石川県:16,福井県:17,山梨県:18,長野県:19,
     岐阜県:20,静岡県:21,愛知県:22,三重県:23,
     滋賀県:24,京都府:25,大阪府:26,兵庫県:27,奈良県:28,和歌山県:29,
     鳥取県:30,島根県:31,岡山県:32,広島県:33,山口県:34,
     徳島県:35,香川県:36,愛媛県:37,高知県:38,
     福岡県:39,佐賀県:40,長崎県:41,熊本県:42,大分県:43,宮崎県:44,鹿児島県:45,
     沖縄県:46
   }


  def get_post_image(width, height) #投稿画像無い時、サイズ指定のためのメソッド
    unless post_image.attached?
     file_path = Rails.root.join('app/assets/images/no_image.jpg')
     post_image.attach(io: File.open(file_path), filename: 'default_image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.search_for(content, method) #投稿キーワード検索用メソッド
    if method == 'perfect'
      # User.joins(:post_location).where(post_locations:{is_active: true}).where(is_deleted: false).where('post_locations.introduction LIKE ?', content)
      PostLocation.joins(:user).where(is_active: true).where(users: {is_deleted: false}).where('post_locations.introduction LIKE ?', content)
    elsif method == 'forward'
      PostLocation.joins(:user).where(is_active: true).where(users: {is_deleted: false}).where('post_locations.introduction LIKE ?', content+'%')
    elsif method == 'backward'
      PostLocation.joins(:user).where(is_active: true).where(users: {is_deleted: false}).where('post_locations.introduction LIKE ?', '%'+content)
    else
      PostLocation.joins(:user).where(is_active: true).where(users: {is_deleted: false}).where('post_locations.introduction LIKE ?', '%'+content+'%')
    end
  end

  def self.search_tag(genre_id,prefecture) #ジャンル・地域絞り込み検索用メソッド
    if prefecture.present? && genre_id.present? #
      PostLocation.joins(:user).where(prefecture: prefecture).where(genre_id: genre_id).where(is_active: true).where(users: {is_deleted: false})
    elsif prefecture.present? && genre_id.empty?
      PostLocation.joins(:user).where(prefecture: prefecture).where(is_active: true).where(users: {is_deleted: false})
    elsif genre_id.present? && prefecture.empty?
      PostLocation.joins(:user).where(genre_id: genre_id).where(is_active: true).where(users: {is_deleted: false})
    else
      PostLocation.none
    end
  end
end
