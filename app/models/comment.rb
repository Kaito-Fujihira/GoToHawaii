class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :post

  validates :comment, presence: true
  validates :comment, length: { maximum: 200 }
end
