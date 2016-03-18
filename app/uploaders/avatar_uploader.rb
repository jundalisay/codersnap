class AvatarUploader < CarrierWave::Uploader::Base

  include Sprockets::Rails::Helper
  include Cloudinary::CarrierWave
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # process :tags => ["photo_album_sample"]
  # process :convert => "jpg"
  
  # def default_url
  #   "/images/avatarblank.png"
  # end

  process :tags => ['user_avatar']

  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :rec320 do
    process :scale => [320, 180]
  end

  version :square150 do
    process :scale => [150, 150]
  end 

  version :square300 do
    process :scale => [300, 300]
  end 

end
