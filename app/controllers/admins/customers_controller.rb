class Admins::CustomersController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins/header'

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
