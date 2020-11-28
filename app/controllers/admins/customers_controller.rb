class Admins::CustomersController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins/header'

  def index
    @customers = Customer.all
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.destroy
    @customers = Customer.all
    render :index
  end
end
