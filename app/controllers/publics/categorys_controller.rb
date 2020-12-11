class Publics::CategorysController < ApplicationController
  before_action :authenticate_customer!, only: [:question, :sns, :youtube]
  layout 'publics/header'

  def question # Q&A
  end

  def sns
  end

  def youtube
  end
  
  def reference_links # 参考資料
  end

end
