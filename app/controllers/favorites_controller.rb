class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = current_user.favorites
    @about_types = @favorites.pluck(:about_type).compact.sort
  end

  def create
    current_user.favorites.where(
      about_type: params[:about_type],
      about_id: params[:about_id]
    ).first_or_create
    redirect_back fallback_location: root_path
  end
  
  def destroy
    current_user.favorites.where(
      about_type: params[:about_type],
      about_id: params[:about_id]
    ).destroy_all
    redirect_back fallback_location:root_path
  end
end