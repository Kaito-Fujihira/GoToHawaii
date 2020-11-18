class Publics::PostsController < ApplicationController
  before_action :authenticate_customer!
  def new
    @post = Post.new
  end

  def index
  end

  def show
    @post = Post.find(params[:id])
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
  end

  def update
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:title, :explanation, :image, :genre_id, :customer_id)
  end
end
