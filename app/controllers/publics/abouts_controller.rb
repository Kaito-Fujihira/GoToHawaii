class Publics::AboutsController < ApplicationController
  before_action :authenticate_customer!
  layout "publics/header"

  def oahu
  end

  def kauai
  end

  def molokai
  end

  def maui
  end

  def lanai
  end

  def hawaii
  end
end
