class Admins::PostsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins/header'

  def index
    @posts = Post.all.page(params[:page]).per(10).reverse_order
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    @posts = Post.all.page(params[:page]).per(10).reverse_order
    render :index
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    @posts = Post.all.page(params[:page]).per(10).reverse_order
    render :index
  end

  private
  def post_params
    params.require(:post).permit(:title, :explanation, :image, :genre_id, :customer_id)
  end

end
