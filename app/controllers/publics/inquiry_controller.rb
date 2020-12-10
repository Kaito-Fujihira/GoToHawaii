class Publics::InquiryController < ApplicationController # お問い合わせ用
  before_action :authenticate_customer!
  layout 'publics/header'

  def index # フォーム
    @inquiry = Inquiry.new
    render :index
  end

  def confirm # 確認画面
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))
    if @inquiry.valid?
      render :confirm # OK。確認画面を表示
    else
      render :index # NG。入力画面を再表示
    end
  end

  def thanks # サンクスページ
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))
    InquiryMailer.received_email(@inquiry).deliver
  end

end
