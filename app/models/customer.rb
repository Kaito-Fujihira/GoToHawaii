class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: %i(facebook google_oauth2)

  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :sns_credentials, dependent: :destroy

  attachment :profile_image

  validates :name, { presence: true, length: { maximum: 20 } }
  validates :email, presence: true

  # マッチング機能
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  def following?(customer_id)
    followings.include?(customer_id)
  end

  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end

  def unfollow!(customer_id)
    relationships.find_by(followed_id: customer_id).destroy # find_byによって1レコードを特定し、destroyメソッドで削除している。
  end

  # 検索機能
  def Customer.search(search, customer_or_post, how_search)
    if customer_or_post == "1"
      if how_search == "1"
        Customer.where(["name LIKE ?", "%#{search}%"])
      else
        Customer.all
      end
    end
  end

  # ゲストログイン機能
  def self.guest
    find_or_create_by!(name: "ゲストユーザー", email: "guest@guest.com") do |customer|
      customer.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

  # SNS認証
  def self.without_sns_data(auth)
    customer = Customer.where(email: auth.info.email).first
    if customer.present?
      sns = SnsCredential.create(
        uid: auth.uid,
        provider: auth.provider,
        customer_id: customer.id
      )
    else
      customer = Customer.new(
        name: auth.info.name,
        email: auth.info.email,
      )
      sns = SnsCredential.new(
        uid: auth.uid,
        provider: auth.provider
      )
    end
    { customer: customer, sns: sns }
  end

  def self.with_sns_data(auth, snscredential)
    customer = Customer.where(id: snscredential.customer_id).first
    if customer.blank?
      customer = Customer.new(
        name: auth.info.name,
        email: auth.info.email,
      )
    end
    { customer: customer }
  end

  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      customer = with_sns_data(auth, snscredential)[:customer]
      sns = snscredential
    else
      customer = without_sns_data(auth)[:customer]
      sns = without_sns_data(auth)[:sns]
    end
    { customer: customer, sns: sns }
  end
  
  # 退会機能
  def active_for_authentication?
    super && (is_deleted == "有効") # is_deletedがfalse(有効)の場合はログイン可能
  end

  enum country: {
    日本: 0,
    ハワイ: 1,
    アメリカ本土: 2,
    その他の国: 3,
  }

  enum visit_time: {
    なし: 0,
    １～３回: 1,
    ４～６回: 2,
    ６回以上: 3,
  }

  enum is_deleted: {
    有効: false,
    退会済み: true,
  }
end
