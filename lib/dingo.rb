require 'enumerator'

class Dingo
  DEFAULT_WORD_PATH = "../../dingo.txt"
  SENTENCE_LENGTH   = 6

  class << self
    def words(random: Random.new, source_words: aussie_copy)
      Enumerator.new do |y|
        loop do
          y.yield aussie_word(source_words, random)
        end
      end
    end

    def sentences(random: Random.new, source_words: aussie_copy)
      Enumerator.new do |y|
        loop do
          y.yield aussie_sentence(source_words, random)
        end
      end
    end

    def paragraphs(random: Random.new, source_words: aussie_copy)
      Enumerator.new do |y|
        loop do
          y.yield aussie_paragraph(source_words, random)
        end
      end
    end

    def reset
      @aussie_copy = nil
      @source_words = nil
    end

    private

    def aussie_copy
      @aussie_copy ||= File.read(File.expand_path(DEFAULT_WORD_PATH, __FILE__)).lines.map(&:chomp)
    end

    def aussie_word(source_words, random)
      @source_words ||= source_words.select { |w| !w.include?(" ") }
      @source_words.sample(random: random)
    end

    def aussie_sentence(source_words, random)
      sentence = source_words.sample(SENTENCE_LENGTH, random: random).join(" ") + "."
      sentence.capitalize!
      sentence
    end

    def aussie_paragraph(source_words, random)
      sentences.take(4).join(" ")
    end
  end
end
