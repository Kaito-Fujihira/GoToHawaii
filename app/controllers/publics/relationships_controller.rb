class Publics::RelationshipsController < ApplicationController
  layout 'publics/header'

  def create
    customer = Customer.find(params[:customer_id])
    current_customer.follow(customer.id)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    customer = Customer.find(params[:customer_id])
    current_customer.unfollow!(customer)
    redirect_back(fallback_location: root_path)
  end

  def followings
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings
  end

  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers
  end
end
