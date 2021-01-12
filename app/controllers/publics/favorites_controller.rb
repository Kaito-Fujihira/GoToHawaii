class Publics::FavoritesController < ApplicationController # いいね機能
  before_action :authenticate_customer!

  def create
    @post = Post.find(params[:post_id])
    unless @post.favorited_by?(current_customer)
      favorite = @post.favorites.new(customer_id: current_customer.id)
      favorite.save
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    if @post.favorited_by?(current_customer)
      favorite = current_customer.favorites.find_by(post_id: @post.id)
      favorite.destroy
    end
  end
end
