require 'enumerator'

class Dingo
  def self.words
    Enumerator.new do |y|
      loop do
        y.yield "one"
      end
    end
  end
end
