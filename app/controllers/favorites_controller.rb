class FavoritesController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_xhr, only: [:create, :destroy]

  def index
    @favorites = current_user.favorites
    @about_types = @favorites.pluck(:about_type)
                             .compact
                             .uniq
                             .sort
  end

  def create
    @about =  params[:about_type].constantize.find_by(id: params[:about_id])
    return unless @about

    current_user.favorites.where(
      about_type: @about.class.name,
      about_id: @about.id
    ).first_or_create
  end
  
  def destroy
    current_user.favorites.where(
      about_type: params[:about_type],
      about_id: params[:about_id]
    ).destroy_all
  end

  private

  def ensure_xhr
    redirect_back(fallback_location: root_path) unless request.xhr?
  end

end