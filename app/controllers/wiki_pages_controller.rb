class WikiPagesController < ApplicationController
  authorize_resource :wiki_page
  acts_as_wiki_pages_controller

  def show_allowed?
    begin
      authorize! :read, @page
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
      authorize! :edit, @page
      true
    rescue
      false
    end
  end
end
