class WikiPagesController < ApplicationController
  authorize_resource :wiki_page
  acts_as_wiki_pages_controller

  def show_allowed?
    begin
      if @page.persisted?
        authorize! :read, @page
      else
        authorize! :read, WikiPage
      end
      true
    rescue
      false
    end
  end

  def history_allowed?
    show_allowed?
  end

  def edit_allowed?
    begin
      if @page.persisted?
        authorize! :edit, @page
      else
        authorize! :edit, WikiPage
      end
      true
    rescue
      false
    end
  end
end
