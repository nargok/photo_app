class PhotosController < ApplicationController
  require 'net/http'

  before_action :require_login
  before_action :set_photo, only: [:new, :create]

  def index
    @photos = current_user.photos.order('created_at DESC')
  end

  def new
  end

  def create
    unless photo_params[:filename].blank?
      upload_file = photo_params[:filename]
      output_path = Rails.root.join('public/images', upload_file.original_filename)
      @photo.filename = upload_file.original_filename
    end
    @photo.title = photo_params[:title]
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

  def callback
    code = params[:code]

    params = {
      'client_id' => Constants::CLIENT_ID,
      'client_secret' => Constants::CLIENT_SECRET,
      'redirect_uri' => Constants::REDIRECT_URI,
      'grant_type' => Constants::GRANT_TYPE,
      'code' => code
    }

    res = Net::HTTP.post_form(URI.parse(Constants::GET_TOKEN_PATH), params)
    api_response = JSON.parse(res.body)
    token = api_response['access_token']

    session[:tweet_app_token] =  token

    redirect_to photos_path
  end

  def tweet
    # Headerをつくる
    uri = URI.parse('https://arcane-ravine-29792.herokuapp.com/api/tweets')
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri)
    req['Content-Type'] = 'application/json'
    req['Authorization'] = 'Bearer ' + session[:tweet_app_token]

    # Body
    @photo = Photo.find(params[:id])
    image_path = 'http://' + request.host_with_port + '/images/' + @photo.filename
    @params = {
      'text' => @photo.title,
      'url' => image_path
    }.to_json

    req.body = @params
    res = https.request(req)

    # 写真一覧へリダイレクトする
    redirect_to photos_path
  end

  private
  def photo_params
    params.require(:photo).permit(:title, :filename)
  end

  def set_photo
    @photo = Photo.new
  end
end
