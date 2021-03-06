class ItemAvatarUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :xlarge do
    process resize_to_fill: [2200, 512]
  end

  version :large do
    process resize_to_fill: [1200, 512]
  end

  version :middle do
    process resize_to_fill: [992, 512]
  end

  version :small do
    process resize_to_fill: [768, 512]
  end

  version :normal do
    process resize_to_fill: [600, 512]
  end

  version :xlarge_half do
    process resize_to_fill: [2200, 206]
  end

  version :large_half do
    process resize_to_fill: [1200, 206]
  end

  version :middle_half do
    process resize_to_fill: [992, 206]
  end

  version :small_half do
    process resize_to_fill: [768, 206]
  end

  version :normal_half do
    process resize_to_fill: [600, 206]
  end

  version :thumb_xlarge do
    process resize_to_fill: [260, 150]
  end

  version :thumb_large do
    process resize_to_fill: [220, 150]
  end

  version :thumb_middle do
    process resize_to_fill: [140, 150]
  end

  version :thumb_small do
    process resize_to_fill: [370, 150]
  end

  version :thumb do
    process resize_to_fill: [280, 150]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
