class UploadsController < ApplicationController
  def index
    @images = ActiveStorage::Blob.all
  end

  def create
    upload = Upload.new(upload_params)
    if upload.save
      redirect_to uploads_path, notice: 'Images were successfully uploaded.'
    else
      redirect_to uploads_path, error: 'Something went wrong, Please try again.'
    end
  end

  private

  def upload_params
    params.require(:upload).permit(images: [])
  end
end