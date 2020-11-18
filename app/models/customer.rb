class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # フォローしているユーザーを取り出す(user.followedを出来るようにする。)
  # 自分がフォローされる（被フォロー）側の関係性
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :follower_relationships, source: :follower

  #フォローされているユーザーを取り出す(user.followersを出来るようにする。)
  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

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
