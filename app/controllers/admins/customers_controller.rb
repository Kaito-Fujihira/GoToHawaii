class Admins::CustomersController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins/header'

  def index
    @customers = Customer.all.page(params[:page]).per(10).reverse_order
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.destroy
    @customers = Customer.all.page(params[:page]).per(10).reverse_order
    render :index
  end
end
