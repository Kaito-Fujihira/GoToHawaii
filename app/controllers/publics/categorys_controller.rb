class Publics::CategorysController < ApplicationController
  before_action :authenticate_customer!
  layout 'publics/header'

  def about
    @customer = current_customer
  end

  def question
  end

  def sns
  end
end
