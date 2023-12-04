class MaterialsController < ApplicationController
  def index
    @materials = Material.all.ordered.page(params[:page])
  end

  def show
    @material = Material.find_by!(slug: params[:slug])
  end
end
