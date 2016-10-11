require 'minitest/autorun'
require 'digest/md5'

class TestSE2J < Minitest::Test

  def test_xml_regex
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb stackoverflow 1732454 | md5`)
    assert_equal md5, "d52540aba8c5a3ab1c48345160fc53ae"
  end
end
