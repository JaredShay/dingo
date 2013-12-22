require 'enumerator'

class Dingo
  class << self
    def words
      Enumerator.new do |y|
        loop do
          y.yield aussie_words.sample
        end
      end
    end

    private

    def aussie_words
      @words ||= File.read(File.expand_path("../../dingo.txt", __FILE__)).lines.map(&:chomp)
    end
  end
end
