class WorkCategoriesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @work_category.save
      redirect_to(work_categories_path, :notice => t('controllers.work_categories.create.success', :default => 'The category was successfully created.'))
    else
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @work_category.update_attributes(params[:work_category])
      redirect_to(work_categories_path, :notice => t('controllers.work_categories.update.success', :default => 'The category was successfully updated.'))
    else
      render :action => "edit"
    end
  end

  def destroy
    if @work_category.destroy
      flash[:notice] = t('controllers.work_categories.destroy.success', :default => "Category deleted")
    else
      flash[:error] = t('controllers.work_categories.destroy.error', :default => "Error deleting the category")
    end
    redirect_to :back
  end
end
