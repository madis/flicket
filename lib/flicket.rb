require "flicket/version"

module Flicket
  class CLI
    def self.start(params)
      puts "Flicket"
      puts "Using initial keywords #{params.join(' ')}"
    end
  end
end
