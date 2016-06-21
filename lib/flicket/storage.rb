require 'fileutils'
module Flicket
  class Storage
    def call(file_path)
      FileUtils.mv file_path, "#{collage_filename}.png"
    end

    private

    def collage_filename
      now = Date.new
      timestamp = now.strftime('%Y%m%d%H%M%S')
      "collage-#{timestamp}"
    end
  end
end
