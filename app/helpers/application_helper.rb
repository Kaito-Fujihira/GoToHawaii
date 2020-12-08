module ApplicationHelper
    def page_title
        title = "Go To Hawaii"
        title = @page_title + " - " + title if @page_title
        title
    end
end
