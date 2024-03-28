class UsersController < ApplicationController

  include ApplicationHelper

  def index
    redirect_to root_path
  end

  def show
    @user = User.find_by!(id: params[:id])
    @actors = @user.actors.published.ordered.page(params[:actors_page]).per(8)
    @projects = @user.projects.published.ordered.page(params[:projects_page]).per(8)
    @technics = @user.technics.published.ordered.page(params[:technics_page]).per(8)
    @materials = @user.materials.published.ordered.page(params[:materials_page]).per(8)
    breadcrumb
    add_breadcrumb @user
  end
end
