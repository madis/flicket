require 'ostruct'
require 'flickraw'

require "flicket/version"
require 'flicket/environment'
require 'flicket/app'
require 'flicket/flicker_query'
require 'flicket/downloader'
require 'flicket/keyword_source'
require 'flicket/collage_maker'
require 'flicket/storage'

module Flicket
  class CLI
    def self.start(keywords)
      puts "Flicket"
      puts "Using initial keywords #{keywords.join(' ')}"
      env = setup_env(keywords)
      App.new(env).call
    end

    def self.setup_env(keywords)
      flicker_query = setup_flicker_query
      keyword_source = setup_keyword_source
      keyword_source.add_user_words keywords

      downloader = Downloader.new
      collage_maker = CollageMaker.new
      storage = Storage.new
      Environment.new(
        flicker_query: flicker_query,
        downloader: downloader,
        keyword_source: keyword_source,
        collage_maker: collage_maker,
        storage: storage)
    end

    def self.setup_keyword_source(dictionary='/usr/share/dict/words')
      if File.exist?(dictionary)
        keyword_source = KeywordSource.new(dictionary)
      else
        STDERR.puts "Exiting as dictionary not found at #{dictionary}"
        exit 1
      end
    end

    def self.setup_flicker_query(key=ENV['FLICKR_KEY'], secret=ENV['FLICKR_SECRET'])
      if key != nil && secret != nil
        FlickRaw.api_key = key
        FlickRaw.shared_secret = secret
        FlickerQuery.build(FlickRaw::Flickr.new)
      else
        STDERR.puts "Exiting because environment variables FLICKR_KEY and FLICKR_SECRET were not set"
        exit 1
      end
    end
  end
end
