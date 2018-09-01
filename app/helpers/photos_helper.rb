module PhotosHelper
  def image_path(filename)
    path = Rails.root.join('public/images', filename)
    image_path = 'http://' + request.host_with_port + '/images/' + File.basename(path)
  end
end
