class Admins::PostsController < ApplicationController
  before_action :authenticate_admin!
  layout "admins/header"

  def index
    if @posts = params[:created_at]
      today_posts = Date.today.beginning_of_day..Date.today.end_of_day
      post = Post.where(created_at: today_posts)
      posts = post.all
    else
      posts = Post.all
    end
    @posts = posts.page(params[:page]).per(10).reverse_order
  end
  
  def show
    @post = Post.find(params[:id])
    # @customer = Customer.find(params[:id])
    @genres = Genre.all
    @customer = @post.customer
    @lat = @post.spot.nil?  ? nil :  @post.spot.latitude # 値がnilの場合は左側
    @lng = @post.spot.nil?  ? nil :  @post.spot.longitude
  end 

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      @posts = Post.all.page(params[:page]).per(10).reverse_order
      redirect_to admins_posts_path, notice: "投稿を変更しました。"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      @posts = Post.all.page(params[:page]).per(10).reverse_order
      redirect_to admins_posts_path, notice: "投稿を削除しました。"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :explanation, :image, :genre_id, :customer_id)
  end
end
