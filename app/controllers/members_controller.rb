class MembersController < ApplicationController

  include ApplicationHelper

  def index
    @members = User.lab_member.ordered.page(params[:page])
    breadcrumb
  end

  def show
    @member = User.lab_member.find_by!(id: params[:id])
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
