class Post < ApplicationRecord
  belongs_to :customer
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :spot, dependent: :destroy
  has_many :tags, dependent: :destroy
  accepts_nested_attributes_for :spot

  attachment :image

  validates :title, { presence: true, length: { maximum: 30 } }
  validates :explanation, { presence: true, length: { maximum: 300 } }
  validates :image, presence: true

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  # 検索機能
  def Post.search(search, customer_or_post, how_search)
    if customer_or_post == "2"
      if how_search == "1"
        Post.where(["title LIKE ?", "%#{search}%"])
      elsif how_search == "2"
        Post.where(["title LIKE ?", "%#{search}"])
      elsif how_search == "3"
        Post.where(["title LIKE ?", "#{search}%"])
      elsif how_search == "4"
        Post.where(["title LIKE ?", "#{search}"])
      else
        Posts.all
      end
    end
  end
end
