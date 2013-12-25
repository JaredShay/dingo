require 'enumerator'

class Dingo
  DEFAULT_WORD_PATH = "../../dingo.txt"
  SENTENCE_LENGTH   = 8

  class << self
    def words(random: Random.new, source_words: aussie_copy)
      Enumerator.new do |y|
        loop do
          y.yield aussie_words(source_words).sample(random: random)
        end
      end
    end

    def sentences(random: Random.new, source_words: aussie_copy)
      Enumerator.new do |y|
        loop do
          y.yield aussie_sentences(source_words, random).sample(random: random)
        end
      end
    end

    private

    def aussie_copy
      @aussie_copy = File.read(File.expand_path(DEFAULT_WORD_PATH, __FILE__)).lines.map(&:chomp)
    end

    def aussie_words(source_words)
      @aussie_words = source_words.select { |w| w.length == 1 }
    end

    def aussie_sentences(source_words, random)
      @aussie_sentences = sentencize(source_words, random)
    end

    def sentencize(copy, random)
      sentences = []

      while !copy.empty?
        copy = copy.sample(copy.length, random: random)
        copy[0].capitalize!
        sentences << copy.shift(SENTENCE_LENGTH).join(" ") + "."
      end

      sentences
    end
  end
end
