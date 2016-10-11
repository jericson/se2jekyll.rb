require 'minitest/autorun'
require 'digest/md5'

class TestSE2J < Minitest::Test

  def test_xml_regex
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb stackoverflow 1732454`)
    puts(md5)
    assert_equal md5, "52e9cadba02b9d4faab99c672855416b"
  end
end
