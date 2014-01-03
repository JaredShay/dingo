require 'minitest/autorun'

require 'dingo'

class DingoTest < MiniTest::Unit::TestCase
  def test_skeleton
    assert_equal 4, Dingo.words.take(4).length
  end

  def test_makes_a_lot_of_words
    assert_equal 40, Dingo.words.take(40).length
  end

  def test_makes_sentences_with_full_stops
    assert_equal ".", Dingo.sentences.take(1).first[-1]
  end

  def test_makes_sentences_with_capital_letters
    dingo = Dingo.new(source_words: ["abcdef"])
    assert_equal "A", dingo.sentences.take(1).first[0]
  end

  def test_makes_paragraphs
    dingo = Dingo.new
    assert_equal true, !!(dingo.paragraphs.take(1)[0].match(/(.*\..*){4}/)[0])
  end

  def test_makes_people
    dingo = Dingo.new(source_people: ["naul pewman"])
    assert_equal ["naul pewman"], dingo.people.take(1)
  end

  def test_makes_email_addresses
    dingo = Dingo.new
    assert_equal true, !!(dingo.emails.take(1)[0].match(/.*@.*/)[0])
  end

  def test_removes_spaces_from_email_addresses
    dingo = Dingo.new(source_words: ["domain"], source_people: ["san holo"])
    assert_equal ["san.holo@domain.com.au"], dingo.emails.take(1)
  end

  def test_configurable_sentence_length
    dingo = Dingo.new(sentence_length: 2, source_words: ["a", "b", "c"])
    # length 4 to account for a space and fullstop
    assert_equal 4, dingo.sentences.take(1)[0].length
  end

  def test_configurable_paragraph_length
    dingo = Dingo.new(paragraph_length: 2)
    assert_equal true, !!(dingo.paragraphs.take(1)[0].match(/(.*\..*){2}/)[0])
  end
end
