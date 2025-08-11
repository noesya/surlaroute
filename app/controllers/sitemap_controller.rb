class SitemapController < ApplicationController
  def show
    @home_page = Page.find_by(internal_identifier: 'home')
    @pages = Page.where.not(id: @home_page.id).select(:id, :path, :updated_at)
    @actors = Actor.published.select(:id, :slug, :updated_at)
    @tours = Tour.published.select(:id, :slug, :updated_at)
    @regions = Region.all

    render layout: false
  end
end
