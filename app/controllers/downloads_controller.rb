class DownloadsController < ApplicationController
  before_action :authenticate_user!

  def download_from_page_block

  end

  def download_from_structure_item
    file = Structure::Value::File.find(params[:file])
    about = file.value.about
    attachment = file.file
    blob = attachment.blob
    data = URI.parse(attachment.url).read
    User::Log.create(
      user: current_user,
      about: about,
      blob: blob
    )
    send_data data,
              type: "#{attachment.content_type}",
              disposition: "attachment; filename=#{attachment.filename.to_s}"
  end

end