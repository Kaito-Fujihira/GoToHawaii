class Admins::HomesController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins/header'

  def top
  end
end
