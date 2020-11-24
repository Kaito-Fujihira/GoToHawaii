class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :follower_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  def following?(customer_id)
    self.followings.include?(customer_id)
  end

  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end

  def unfollow!(customer_id)
    relationships.find_by(followed_id: customer_id).destroy #find_byによって1レコードを特定し、destroyメソッドで削除している。
  end

  def Customer.search(search, customer_or_post, how_search)
    if customer_or_post == "1"
      if how_search == "1"
        Customer.where(['name LIKE ?', "%#{search}%"])
      elsif how_search == "2"
        Customer.where(['name LIKE ?', "%#{search}"])
      elsif how_search == "3"
        Customer.where(['name LIKE ?', "#{search}%"])
      elsif how_search == "4"
        Customer.where(['name LIKE ?', "#{search}"])
      else
        Customers.all
      end
    end
  end

  enum country: {
    日本: 0,
    ハワイ:1,
    アメリカ本土: 2,
    その他の国:3
  }

  enum visit_time: {
    なし: 0,
    １～３回: 1,
    ４～６回: 2,
    ６回以上: 3
  }
end
