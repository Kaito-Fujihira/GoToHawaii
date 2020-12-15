module ApplicationHelper
  def page_title
    title = "Go to Hawaii"
    title = @page_title + " - " + title if @page_title
    title
  end
end
