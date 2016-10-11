require 'minitest/autorun'

class TestSE2J < Minitest::Test

  def test_xml_regex
    assert_equal `ruby se2jekyll.rb stackoverflow 1732454 | md5`,
                 "52e9cadba02b9d4faab99c672855416b\n"
  end
end
