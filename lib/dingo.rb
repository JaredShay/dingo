require 'enumerator'
require 'forwardable'

class Dingo
  extend SingleForwardable

  dir = "../../word_lists/"
  DEFAULT_WORD_PATH   = File.expand_path(dir + "dingo.txt", __FILE__)
  DEFAULT_PEOPLE_PATH = File.expand_path(dir + "people.txt", __FILE__)

  def_delegators :dingo, :words, :sentences, :paragraphs, :people, :emails

  def initialize(random:           Random.new,
                 source_words:     read_file(DEFAULT_WORD_PATH),
                 source_people:    read_file(DEFAULT_PEOPLE_PATH),
                 sentence_length:  6,
                 paragraph_length: 4)

    @random           = random
    @source_words     = source_words.select { |w| !w.include?(" ") }
    @source_people    = source_people
    @all_words        = source_words + source_people
    @sentence_length  = sentence_length
    @paragraph_length = paragraph_length
  end

  def words;      infinite_sequence { word } end
  def sentences;  infinite_sequence { sentence } end
  def paragraphs; infinite_sequence { paragraph } end
  def people;     infinite_sequence { person } end
  def emails;     infinite_sequence { email } end

  private

  def read_file(file_path)
    File.read(file_path).lines.map(&:chomp)
  end

  def infinite_sequence(&block)
    Enumerator.new do |y|
      loop do
        y.yield block.call
      end
    end
  end

  def word
    @source_words.sample(random: @random)
  end

  def sentence
    sentence = @all_words.
      sample(@sentence_length, random: @random).
      join(" ") + "."
    sentence.capitalize!
    sentence
  end

  def paragraph
    sentences.take(@paragraph_length).join(" ")
  end

  def person
    @source_people.sample(random: @random)
  end

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
