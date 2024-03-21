class UsersController < ApplicationController

  include ApplicationHelper

  def index
    redirect_to root_path
  end

  def show
    @user = User.find_by!(id: params[:id])
    @actors = @user.actors.ordered.page(params[:actors_page]).per(8)
    @projects = @user.projects.ordered.page(params[:projects_page]).per(8)
    @technics = @user.technics.ordered.page(params[:technics_page]).per(8)
    @materials = @user.materials.ordered.page(params[:materials_page]).per(8)
    breadcrumb
    add_breadcrumb @user
  end
end
