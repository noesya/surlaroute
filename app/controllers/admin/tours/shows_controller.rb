class Tour::ShowsController < ApplicationController
  before_action :set_tour_show, only: %i[ show edit update destroy ]

  # GET /tour/shows
  def index
    @tour_shows = Tour::Show.all
  end

  # GET /tour/shows/1
  def show
  end

  # GET /tour/shows/new
  def new
    @tour_show = Tour::Show.new
  end

  # GET /tour/shows/1/edit
  def edit
  end

  # POST /tour/shows
  def create
    @tour_show = Tour::Show.new(tour_show_params)

    if @tour_show.save
      redirect_to @tour_show, notice: "Show was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tour/shows/1
  def update
    if @tour_show.update(tour_show_params)
      redirect_to @tour_show, notice: "Show was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tour/shows/1
  def destroy
    @tour_show.destroy!
    redirect_to tour_shows_url, notice: "Show was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour_show
      @tour_show = Tour::Show.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tour_show_params
      params.require(:tour_show).permit(:tour_id, :place_id, :published)
    end
end
