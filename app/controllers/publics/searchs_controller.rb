class Publics::SearchsController < ApplicationController
  before_action :authenticate_customer!
  layout 'publics/header'

  def search # 検索機能
    @customer_or_post = params[:option]
    @how_search = params[:choice]
    if @customer_or_post == "1"
      @customers = Customer.search(params[:search], @customer_or_post, @how_search).page(params[:page]).per(10).reverse_order
    else
      @posts = Post.search(params[:search], @customer_or_post, @how_search).page(params[:page]).per(12).reverse_order
    end
  end

end
