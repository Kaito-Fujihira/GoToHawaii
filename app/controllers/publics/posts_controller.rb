class Publics::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]
  layout 'publics/header'

  def new
    @post = Post.new
    @post.build_spot
  end

  def index
    @posts = Post.all.page(params[:page]).per(9).reverse_order
  end

  def show
    @post = Post.find(params[:id])
    @genres= Genre.all
    @comment = Comment.new
    @customer = @post.customer
    @lat = (@post.spot.nil?)? nil :  @post.spot.latitude # 値がnilの場合は左側
    @lng = (@post.spot.nil?)? nil :  @post.spot.longitude
    gon.lat = @lat # @latと@lngの変数をJavaScriptでも扱えるように、それぞれgon.latとgon.lngに代入
    gon.lng = @lng
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    @customer = @post.customer
    if @post.save
      redirect_to post_path(@post), notice: "投稿しました！！"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
    @lat = (@post.spot.nil?)? nil :  @post.spot.latitude #nilの場合は左側
    @lng = (@post.spot.nil?)? nil :  @post.spot.longitude
    gon.lat = @lat # @latと@lngの変数をJavaScriptでも扱えるように、それぞれgon.latとgon.lngに代入
    gon.lng = @lng
  end

  def update
    @post = Post.find(params[:id])
    @lat = (@post.spot.nil?)? nil :  @post.spot.latitude #nilの場合は左
    @lng = (@post.spot.nil?)? nil :  @post.spot.longitude
    gon.lat = @lat # @latと@lngの変数をJavaScriptでも扱えるように、それぞれgon.latとgon.lngに代入
    gon.lng = @lng
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を変更しました。"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, alert: "投稿を削除しました。"
  end

  private
  def post_params
    params.require(:post).permit(:title, :explanation, :image, :genre_id, :customer_id, spot_attributes: [:address])
  end

  def ensure_correct_customer # 会員権限
     post = Post.find(params[:id])
     if current_customer != post.customer
       redirect_to post_path(post)
     end
  end
  
end


