module Flicket
  class App
    MAX_KEYWORD_RETRIES = 10

    class ApplicationError < StandardError; end

    attr_reader :env

    def initialize(env)
      @env = env
    end

    def call
      image_paths = []
      image_paths << obtain_image while image_paths.count < 10
      make_collage(image_paths)
    rescue ApplicationError => e
      puts "Application could not continue. #{e.message}"
    end

    def obtain_image
      tries ||= MAX_KEYWORD_RETRIES

      keyword = env.keyword_source.call
      image_url = env.flicker_query.call(keyword)
      downloaded_image = env.downloader.call(image_url)
    rescue NoImageForKeyword => e
      puts "Image not found for keyword '#{keyword}'. Message: #{e.message}. Retrying"
      if (tries -= 1) > 0
        retry
      else
        raise ApplicationError, "Failed getting image after retrying #{MAX_KEYWORD_RETRIES} times"
      end
    rescue DownloadError => e
      raise ApplicationError, e.message
    end

    def make_collage(images)
      env.storage.call(env.collage_maker.call(images))
    end
  end
end
