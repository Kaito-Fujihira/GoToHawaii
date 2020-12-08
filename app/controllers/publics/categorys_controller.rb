class Publics::CategorysController < ApplicationController
  before_action :authenticate_customer!, only: [:index, :question, :sns, :youtube]
  layout 'publics/header'

  def about
  end

  def index
  end

  def question
  end

  def sns
  end
  
  def oahu
  end 

  def youtube
  end
  
  def reference_links
  end

end
