require 'enumerator'

class Dingo
  DEFAULT_WORD_PATH   = File.expand_path("../../word_lists/dingo.txt", __FILE__)
  DEFAULT_PEOPLE_PATH = File.expand_path("../../word_lists/people.txt", __FILE__)

  def initialize(random:           Random.new,
                 source_words:     initialize_source_words,
                 source_people:    initialize_source_people,
                 sentence_length:  6,
                 paragraph_length: 4)

    @random           = random
    @source_words     = source_words
    @source_people    = source_people
    @sentence_length  = sentence_length
    @paragraph_length = paragraph_length
  end

  def initialize_source_words
    File.read(DEFAULT_WORD_PATH).lines.map(&:chomp)
  end

  def initialize_source_people
    File.read(DEFAULT_PEOPLE_PATH).lines.map(&:chomp)
  end

  def infinite_sequence(&block)
    Enumerator.new do |y|
      loop do
        y.yield block.call
      end
    end
  end

  def self.words; dingo(random: Random.new).words; end
  def words;      infinite_sequence { word }; end
  def word;       @source_words.sample(random: @random); end

  def self.sentences; dingo(random: Random.new).sentences; end
  def sentences;      infinite_sequence { sentence }; end
  def sentence
    sentence = @source_words.sample(@sentence_length, random: @random).join(" ") + "."
    sentence.capitalize!
    sentence
  end

  def self.paragraphs; dingo(random: Random.new).paragraphs; end
  def paragraphs;      infinite_sequence { paragraph }; end
  def paragraph;       sentences.take(@paragraph_length).join(" "); end

  def self.people; dingo(random: Random.new).pepole; end
  def people;      infinite_sequence { person }; end
  def person;      @source_people.sample(random: @random); end

  def self.emails; dingo(random: Random.new).emails; end
  def emails;      infinite_sequence { email }; end
  def email
    people.take(1)[0].gsub(" ", ".") + "@" + words.take(1)[0] + ".com.au"
  end

  class << self
    private

    def dingo(random: Random.new)
      @@dingo ||= Dingo.new(random: random)
    end
  end
end
