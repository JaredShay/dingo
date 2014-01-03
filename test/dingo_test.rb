require 'minitest/autorun'

require 'dingo'

class DingoTest < MiniTest::Unit::TestCase
  def test_skeleton
    assert_equal 4, dingo.words.take(4).length
  end

  def test_makes_a_lot_of_words
    assert_equal 40, dingo.words.take(40).length
  end

  def test_makes_sentences_with_full_stops
    assert_equal ".", dingo.sentences.take(1).first[-1]
  end

  def test_makes_sentences_with_capital_letters
    dingo = dingo(source_words: ["abcdef"])
    assert_equal "A", dingo.sentences.take(1).first[0]
  end

  def test_makes_paragraphs
    assert_equal true, !!(dingo.paragraphs.take(1)[0].match(/(.*\..*){4}/)[0])
  end

  def test_makes_people
    dingo = dingo(source_people: ["naul pewman"])
    assert_equal ["naul pewman"], dingo.people.take(1)
  end

  def test_makes_email_addresses
    assert_equal true, !!(dingo.emails.take(1)[0].match(/.*@.*/)[0])
  end

  def test_removes_spaces_from_email_addresses
    dingo = dingo(source_words: ["domain"], source_people: ["san holo"])
    assert_equal ["san.holo@domain.com.au"], dingo.emails.take(1)
  end

  def test_configurable_sentence_length
    dingo = dingo(sentence_length: 2, source_words: ["a", "b", "c"])
    # length 4 to account for a space and fullstop
    assert_equal 4, dingo.sentences.take(1)[0].length
  end

  def test_configurable_paragraph_length
    dingo = dingo(paragraph_length: 2)
    assert_equal true, !!(dingo.paragraphs.take(1)[0].match(/(.*\..*){2}/)[0])
  end

  def test_class_api
    assert Dingo.words.take(1)
    assert Dingo.sentences.take(1)
    assert Dingo.paragraphs.take(1)
    assert Dingo.people.take(1)
    assert Dingo.emails.take(1)
  end

  def dingo(opts = {})
    Dingo.new(opts)
  end
end
