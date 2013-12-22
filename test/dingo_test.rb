require 'minitest/autorun'

require 'dingo'

class DingoTest < MiniTest::Unit::TestCase
  def test_skeleton
    assert_equal 4, Dingo.words.take(4).length
  end

  def test_makes_a_lot_of_words
    assert_equal 40, Dingo.words.take(40).length
  end
end
