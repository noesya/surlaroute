class Admin::CommentsController < Admin::ApplicationController
  load_and_authorize_resource class: User::Comment

  def index
    @comments = @comments.autofilter(params[:filters])
                          .ordered
                          .page(params[:page])
    breadcrumb
  end

  def todo
    @comments = User::Comment.pending.ordered.page(params[:page])
    breadcrumb
    add_breadcrumb t('admin.comments.todo')
  end

  def approve
    @comment.status = :approved
    @comment.save
    redirect_to todo_admin_comments_path
  end

  def reject
    @comment.status = :rejected
    @comment.save
    redirect_to todo_admin_comments_path
  end

  protected

  def breadcrumb
    super
    add_breadcrumb t('admin.comments.title'), admin_comments_path
  end
end