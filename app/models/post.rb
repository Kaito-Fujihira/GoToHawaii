class Post < ApplicationRecord
  belongs_to :customer
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  attachment :image

  def favorited_by?(current_customer)
    favorites.where(customer_id: customer.id).exists?
  end

end
