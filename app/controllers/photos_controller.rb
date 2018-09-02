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

    # パラメータは一度素でここで作成する　→　後でconstants化する
    # パラメータを作成する
    params = {
      'client_id' => 'f17620f69de54893c5df06796da7271e0fa6911e318bff0b8ea54a7cce7980ce',
      'client_secret' => 'e3140d157ced3fbbc2900bd64ad4f93b1a0ae034174a89ce1844e3ad61715d4e',
      'redirect_uri' => 'http://localhost:3000/oauth/callback',
      'grant_type' => 'authorization_code',
      'code' => code
    }

    # http通信する
    res = Net::HTTP.post_form(URI.parse('https://arcane-ravine-29792.herokuapp.com/oauth/token'), params)
    api_response = JSON.parse(res.body)
    token = api_response['access_token']

    # 取得したアクセストークンをsessionに追加する
    session[:tweet_app_token] =  token

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
