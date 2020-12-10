class Admins::HomesController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins/header'

  def top
    today_posts = Date.today.beginning_of_day..Date.today.end_of_day
		@posts = Post.where(created_at: today_posts)
  end
  
end
