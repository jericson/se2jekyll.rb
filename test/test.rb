require 'minitest/autorun'

class TestSE2J < Minitest::Test

  def test_xml_regex
    assert_equal `ruby se2jekyll.rb stackoverflow 1732454 | cksum`,
                 "2904996530 4680\n"
  end
end
