class Publics::CustomersController < ApplicationController
  before_action :authenticate_customer!
  layout 'publics/header'
  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.page(params[:page]).per(12).reverse_order
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :emali, :birthday, :country, :visit_time)
  end
end
