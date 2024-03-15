class MembersController < ApplicationController

  include ApplicationHelper

  def index
    @members = User.lab_member.ordered.page(params[:page])
    breadcrumb
  end

  def show
    @member = User.lab_member.find_by!(id: params[:id])
    @actors = @member.actors.ordered.page(params[:actors_page]).per(8)
    @projects = @member.projects.ordered.page(params[:projects_page]).per(8)
    @technics = @member.technics.ordered.page(params[:technics_page]).per(8)
    @materials = @member.materials.ordered.page(params[:materials_page]).per(8)
    breadcrumb
    add_breadcrumb @member
  end

  protected

  def breadcrumb
    super
    page_lab = Page.find_by(internal_identifier: 'le-lab') 
    add_breadcrumb page_lab, page_path(page_lab)
    add_breadcrumb t('footer.members'), members_path
  end
end
