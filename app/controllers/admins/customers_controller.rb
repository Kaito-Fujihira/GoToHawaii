class Admins::CustomersController < ApplicationController
  before_action :authenticate_admin!
  layout "admins/header"

  def index
    @customers = Customer.all.page(params[:page]).per(10).reverse_order
  end

  def edit
    @customer = Customer.find(params[:id])
    if @customer == Customer.find_by(email: "guest@guest.com") # ゲストユーザーは編集ページへ遷移させない
      redirect_to admins_customers_path, alert: "ゲストユーザーのため変更はお控えください。"
    end 
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      @customers = Customer.all.page(params[:page]).per(10).reverse_order
      redirect_to admins_customers_path, notice: "会員情報を変更しました。"
    else
      render :edit
    end
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.destroy
    @customers = Customer.all.page(params[:page]).per(10).reverse_order
    render :index, notice: "会員を削除しました。"
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :profile_image, :birthday, :country, :visit_time, :is_deleted)
  end
  
end
