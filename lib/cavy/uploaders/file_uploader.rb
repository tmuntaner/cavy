module Cavy
  class FileUploader < CarrierWave::Uploader::Base
    storage :file

    def store_dir
      'uploads'
    end
  end
end
