class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: %i[facebook google_oauth2]

  attachment :profile_image

  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :sns_credentials, dependent: :destroy


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

  def self.guest
    find_or_create_by!(email: 'guest@guest.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

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
    return { customer: customer ,sns: sns}
  end

   def self.with_sns_data(auth, snscredential)
    customer = Customer.where(id: snscredential.customer_id).first
    unless customer.present?
      customer = Customer.new(
        name: auth.info.name,
        email: auth.info.email,
      )
    end
    return {customer: customer}
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
    return { customer: customer,sns: sns}
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
