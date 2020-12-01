class Publics::InquiryController < ApplicationController # お問い合わせ用
  before_action :authenticate_customer!
  layout 'publics/header'

  def index
    @inquiry = Inquiry.new
    render :index
  end

  def confirm
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))
    if @inquiry.valid?
      # OK。確認画面を表示
      render :confirm
    else
      # NG。入力画面を再表示
      render :index
    end
  end

  def thanks
    # メール送信
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))
    InquiryMailer.received_email(@inquiry).deliver
  end

end
