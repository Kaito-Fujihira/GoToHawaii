class Admins::AdminsController < ApplicationController
  before_action :authenticate_admin!
  layout "admins/header"

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin == Admin.find_by(email: "admin@guest.com") # ゲストユーザーの場合
      redirect_to edit_admins_admin_path(@admin), alert: "ゲストユーザーのため変更はお控えください。"
    elsif @admin.update(admin_params)
      redirect_to edit_admins_admin_path(@admin), notice: "管理者情報を編集しました。"
    else
      render :edit
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:email)
  end
end
