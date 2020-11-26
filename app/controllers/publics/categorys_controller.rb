class Publics::CategorysController < ApplicationController
  before_action :authenticate_customer!, only: [:category, :question, :sns, :youtube]
  layout 'publics/header'

  def about
  end

  def index
  end

  def question
  end

  def sns
  end

  def youtube
  end

end
