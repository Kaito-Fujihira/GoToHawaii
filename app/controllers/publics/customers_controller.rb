class Publics::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update]
  layout "publics/header"

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.page(params[:page]).per(12).reverse_order
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = Customer.find(current_customer.id)
    if @customer == Customer.find_by(email: "guest@guest.com") # ゲストユーザーの場合
      redirect_to customer_path(@customer), alert: "ゲストユーザーのため退会や変更はお控えください。"
    elsif @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "ユーザー情報を更新しました。"
    else
      render :edit
    end
  end

  def withdraw # 退会用アクション
    @customer = current_customer
    if @customer == Customer.find_by(email: "guest@guest.com") # ゲストユーザーの場合
      redirect_to edit_customer_path(@customer), alert: "ゲストユーザーのため退会や変更はお控えください。"
    else
      @customer.update(is_deleted: "退会済み")
      reset_session
      redirect_to root_path, alert: "退会しました。"
    end 
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :profile_image, :birthday, :country, :visit_time)
  end

  def ensure_correct_customer # 会員権限
    customer = Customer.find(params[:id])
    if current_customer != customer
      redirect_to customer_path(current_customer.id)
    end
  end
end
