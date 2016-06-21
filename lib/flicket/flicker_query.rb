module Flicket
  class NoImageForKeyword < StandardError; end
  class KeywordMissing < StandardError; end

  class BaseCommand
    attr_reader :api

    def initialize(flickraw)
      @api = flickraw
    end
  end

  class SearchCommand < BaseCommand
    def call(text)
      api.photos.search({text: text, sort: 'interestingness-desc', per_page: 10})
    end
  end

  class InfoCommand < BaseCommand
    def call(photo_id)
      api.photos.getInfo(photo_id: photo_id)
    end
  end

  class SizesCommand < BaseCommand
    def call(photo_id)
      api.photos.getSizes(photo_id: photo_id)
    end
  end

  class FlickerQuery
    def self.build(flickraw)
      search_command = SearchCommand.new(flickraw)
      sizes_command = SizesCommand.new(flickraw)
      new(search_command: search_command, sizes_command: sizes_command)
    end

    def initialize(search_command:, sizes_command:)
      @search_command = search_command
      @sizes_command = sizes_command
    end

    def call(keyword)
      raise KeywordMissing, "Search keyword is required (can't be nil)" if keyword.nil?
      puts "Searching images for keyword '#{keyword}'"
      results = @search_command.call(keyword)
      raise NoImageForKeyword if results.count == 0
      get_image_url(results.first['id'])
    end

    private

    def get_image_url(photo_id)
      sizes = @sizes_command.call(photo_id)
      middle = sizes.count / 2 # Will pick middle sized image from the ones available
      sizes[middle]['source']
    end
  end
end
