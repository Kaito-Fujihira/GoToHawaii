class Post < ApplicationRecord
  belongs_to :customer
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  attachment :image

end
