class Admin::CommentsController < Admin::ApplicationController
  load_and_authorize_resource class: "User::Comment"

  def index
    @comments = @comments.autofilter(params[:filters])
                         .ordered
                         .page(params[:page])
    breadcrumb
  end

  def pending
    @comments = User::Comment.pending
                             .autofilter(params[:filters])
                             .ordered
                             .page(params[:page])
    breadcrumb
    add_breadcrumb t('admin.comments.pending')
  end

  def approve
    @comment.approved!
  end

  def reject
    @comment.rejected!
  end

  protected

  def breadcrumb
    super
    add_breadcrumb t('admin.comments.title'), admin_comments_path
  end
end