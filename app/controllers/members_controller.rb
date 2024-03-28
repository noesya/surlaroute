class MembersController < ApplicationController

  include ApplicationHelper

  def index
    @members = Actor.lab_member.ordered.page(params[:page])
    breadcrumb
  end

  protected

  def breadcrumb
    super
    page_lab = Page.find_by(internal_identifier: 'le-lab')
    add_breadcrumb page_lab, page_path(page_lab)
    add_breadcrumb t('footer.members')#, members_path
  end
end
