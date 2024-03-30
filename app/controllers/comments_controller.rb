class CommentsController < ApplicationController

  before_action :ensure_authorize, only: [:index, :create]
  before_action :load_and_authorize_comment, except: [:index, :create]

  def index
    @comments = current_user.comments.ordered
  end

  def edit
  end

  def create
    @comment = current_user.comments.create comment_params
    redirect_back fallback_location: @comment.about
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.about
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to @about
  end
  
  protected

  def ensure_authorize
    redirect_back fallback_location: root_path, alert: 'Vous devez être connecté avec un compte abonné pour accéder à cette partie' unless can?(:create, User::Comment) 
  end

  def load_and_authorize_comment
    @comment = User::Comment.find params[:id]
    authorize! :destroy, @comment
    @about = @comment.about
  end

  def comment_params
    params.require(:user_comment)
          .permit(:title, :text, :about_id, :about_type, :reply_to_id)
  end
end