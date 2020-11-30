class Publics::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update]
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
      redirect_to customer_path(@customer), notice: "ユーザー情報を更新しました。"
    else
      render :edit
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :emali, :profile_image, :birthday, :country, :visit_time)
  end

  def ensure_correct_customer
     customer = Customer.find(params[:id])
     if current_customer != customer
       redirect_to customer_path(current_customer.id)
     end
  end

end
