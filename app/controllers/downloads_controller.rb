class DownloadsController < ApplicationController
  before_action :authenticate_user!

  def download_from_page_block
    @blob = ActiveStorage::Blob.find(params[:blob])
    block = Page::Block.find(params[:block])
    @about = block.page
    log_and_send
  end

  def download_from_structure_item
    file = Structure::Value::File.find(params[:file])
    @about = file.value.about
    attachment = file.file
    @blob = attachment.blob
    log_and_send
  end

  protected

  def log_and_send
    data = URI.parse(@blob.url).read
    User::Log.create(
      user: current_user,
      about: @about,
      blob: @blob
    )
    send_data data,
              type: "#{@blob.content_type}",
              disposition: "attachment; filename=#{@blob.filename.to_s}"
  end

end