class Publics::RelationshipsController < ApplicationController
  layout "publics/header"

  def create
    @customer = Customer.find(params[:customer_id])
    current_customer.follow(@customer.id)
  end

  def destroy
    @customer = Customer.find(params[:customer_id])
    current_customer.unfollow!(@customer)
  end

  def followings # フォロー一覧
    @customer = Customer.find(params[:customer_id])
    @customers = @customer.followings
  end

  def followers # フォロワー一覧
    @customer = Customer.find(params[:customer_id])
    @customers = @customer.followers
  end
end
