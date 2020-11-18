class Publics::PostsController < ApplicationController
  before_action :authenticate_customer!
  layout 'publics/header'

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def show
    @customer = current_customer
    @post = Post.find(params[:id])
    @genres= Genre.all
    @comment = Comment.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    @customer = @post.customer
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @genres= Genre.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :explanation, :image, :genre_id, :customer_id)
  end
end
