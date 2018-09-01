class PhotosController < ApplicationController
  before_action :require_login
  before_action :set_photo, only: [:new, :create]

  def index
    @photos = current_user.photos.order('created_at DESC')
  end

  def new
  end

  def create
    upload_file = photo_params[:filename]
    output_path = Rails.root.join('public/images', upload_file.original_filename)

    @photo.title = photo_params[:title]
    @photo.filename = upload_file.original_filename
    @photo.user_id = current_user.id

    if @photo.save
      File.open(output_path, 'w+b') do |fp|
        fp.write upload_file.read
      end
      redirect_to action: :index
    else
      render :new
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:title, :filename)
  end

  def set_photo
    @photo = Photo.new
  end
end
