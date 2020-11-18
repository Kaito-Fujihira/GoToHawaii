class Publics::HomesController < ApplicationController
  layout 'publics/header'
  def top
    @posts = Post.all
  end

  def about
  end
end
