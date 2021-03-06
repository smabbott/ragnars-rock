class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb_square do
    process :resize_to_fill => [200, 200]
  end

  version :thumb_square_small do
    process :resize_to_fill => [100, 100]
  end

  version :thumb_wide do
    process :resize_to_fill => [300, 100]
  end

  # version :thumb_wide_grey do
  #   process :grey_version
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

private
 
  # FIXME: this doesn't work as expected
  # def grey_version
  #   manipulate! do |img|
  #     img.combine_options do |c|
  #       # c.trim
  #       c.resize      "300x#100>"
  #       # c.resize      "100x300<"
  #       c.colorspace 'Gray'
  #       # c.sigmoidal_contrast "10x0"
  #     end
  #     img
  #   end
  # end

end
