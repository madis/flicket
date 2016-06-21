require 'fileutils'
require 'date'

module Flicket
  class Storage

    attr_accessor :output_filename

    def call(file_path)
      destination = collage_filename
      FileUtils.mv file_path, destination
      puts "Finished collage is available at #{destination}"
    end

    private

    def collage_filename
      output_filename || ask_filename_from_user
    end

    def ask_filename_from_user
      default = dated_filename
      puts "Enter file name for collage (press ENTER to use '#{default}')"
      filename = STDIN.gets.strip
      if filename.empty?
        default
      else
        filename
      end
    end

    def dated_filename
      now = Date.new
      timestamp = now.strftime('%Y%m%d%H%M%S')
      "collage-#{timestamp}.png"
    end
  end
end
