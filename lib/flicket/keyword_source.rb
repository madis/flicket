module Flicket
  class KeywordSource
    def initialize(dictionary_path)
      @dictionary_path = dictionary_path
      @user_words = []
    end

    def call
      next_user_word || random_dictionary_word
    end

    def add_user_words(words)
      @user_words += words
    end

    private

    def next_user_word
      @user_words.shift
    end

    # Based on http://goo.gl/HbJbR2
    def random_dictionary_word
      chosen_line = nil
      File.foreach(@dictionary_path).each_with_index do |line, number|
        chosen_line = line if rand < 1.0 / (number + 1)
      end
      chosen_line.strip
    end
  end
end
