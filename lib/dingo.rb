require 'enumerator'

class Dingo
  DEFAULT_WORD_PATH   = File.expand_path("../../word_lists/dingo.txt", __FILE__)
  DEFAULT_PEOPLE_PATH = File.expand_path("../../word_lists/people.txt", __FILE__)
  SENTENCE_LENGTH     = 6

  class << self
    def words(random: Random.new, source_words: aussie_words)
      infinite_sequence { aussie_word(source_words, random) }
    end

    def sentences(random: Random.new, source_words: aussie_copy)
      infinite_sequence { aussie_sentence(source_words, random) }
    end

    def paragraphs(random: Random.new, source_words: aussie_copy)
      infinite_sequence { aussie_paragraph(source_words, random) }
    end

    def people(random: Random.new, source_words: aussie_people)
      infinite_sequence { aussie_person(source_words, random) }
    end

    def email_addresses(random: Random.new, source_words: aussie_words, source_people: aussie_people)
      infinite_sequence { aussie_email_address(source_words, source_people, random) }
    end

    def reset
      @aussie_copy = nil
      @source_words = nil
    end

    private

    def infinite_sequence(&block)
      Enumerator.new do |y|
        loop do
          y.yield block.call
        end
      end
    end

    def aussie_copy
      @aussie_copy ||= File.read(DEFAULT_WORD_PATH).lines.map(&:chomp) +
                       aussie_people
    end

    def aussie_people
      @aussie_people ||= File.read(DEFAULT_PEOPLE_PATH).lines.map(&:chomp)
    end

    def aussie_person(source_words, random)
      source_words.sample(random: random)
    end

    def aussie_email_address(source_words, source_people, random)
      source_people.sample(random: random).gsub(" ", ".") +
      "@" +
      source_words.sample(random: random) +
      ".com.au"
    end

    def aussie_words
      @aussie_copy ||= aussie_copy.select { |w| !w.include?(" ") }
    end

    def aussie_word(source_words, random)
      source_words.sample(random: random)
    end

    def aussie_sentence(source_words, random)
      sentence = source_words.sample(SENTENCE_LENGTH, random: random).join(" ") + "."
      sentence.capitalize!
      sentence
    end

    def aussie_paragraph(source_words, random)
      sentences(source_words: source_words, random: random).take(4).join(" ")
    end
  end
end
