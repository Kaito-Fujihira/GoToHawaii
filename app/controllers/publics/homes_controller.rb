class Publics::HomesController < ApplicationController
  before_action :authenticate_customer!
  layout 'publics/homes-header'
  def top
    @posts = Post.all.page(params[:page]).per(9).reverse_order
    @customer = current_customer
    @genres = Genre.all
  end

end
