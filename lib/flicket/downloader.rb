require 'open-uri'
require 'tempfile'

module Flicket
  class DownloadError < StandardError; end

  class Downloader
    def call(url)
      download_to_temp_file(url)
    rescue OpenURI::HTTPError => e
      raise DownloadError, "Unable to download from #{url} #{e.message}"
    end

    private

    def download_to_temp_file(url)
      tempfile = Tempfile.new 'flicket-image'
      IO.copy_stream(open(url, read_timeout: 5), tempfile)
      tempfile.rewind
      puts "Downloaded to #{tempfile.path}"
      tempfile
    end
  end
end
