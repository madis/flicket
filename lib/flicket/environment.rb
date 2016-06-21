module Flicket
  class Environment
    attr_reader :flicker_query, :downloader, :keyword_source, :collage_maker, :storage

    def initialize(params={})
      @flicker_query = params.fetch(:flicker_query)
      @downloader = params.fetch(:downloader)
      @keyword_source = params.fetch(:keyword_source)
      @collage_maker = params.fetch(:collage_maker)
      @storage = params.fetch(:storage)
    end
  end
end
