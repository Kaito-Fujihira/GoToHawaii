class Publics::CommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.customer_id = current_customer.id
    @comment.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
