class Publics::HomesController < ApplicationController
  layout 'publics/homes-header'
  def top
    @posts = Post.all.page(params[:page]).per(9)
    @customer = current_customer
  end

  def about
    @customer = current_customer
  end
end
