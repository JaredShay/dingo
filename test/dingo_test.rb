require 'minitest/autorun'

require 'dingo'

class DingoTest < MiniTest::Unit::TestCase
  def test_skeleton
    assert_equal 4, Dingo.words.take(4).length
  end

  def test_makes_a_lot_of_words
    assert_equal 40, Dingo.words.take(40).length
  end

  def test_makes_only_words
    assert_equal [nil], Dingo.words(source_words: ["more than one word"]).take(1)
  end

  def test_makes_sentences_with_full_stops
    assert_equal ".", Dingo.sentences.take(1).first[-1]
  end

  def test_makes_sentences_with_capital_letters
    assert_equal "A", Dingo.sentences(source_words: ["abcdef"]).take(1).first[0]
  end

  def test_makes_paragraphs
    assert_equal true, !Dingo.paragraphs.take(1)[0].match(/(.*\..*){4}/)[0].empty?
  end
end
