class Publics::CategorysController < ApplicationController
  before_action :authenticate_customer!, only: [:question, :sns, :youtube, :oahu]
  layout 'publics/header'

  def question
  end

  def sns
  end

  def youtube
  end
  
  def reference_links
  end

end
