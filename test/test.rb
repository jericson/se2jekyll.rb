require 'minitest/autorun'
require 'digest/md5'

class TestSE2J < Minitest::Test

  def test_locked_question
    #puts(`ruby se2jekyll.rb stackoverflow 179123`)
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb stackoverflow 179123`)
    #puts(md5)
    assert_equal md5, "718aaed6741267f267d0b1a21945983f"
  end
  
  def test_xml_regex
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb stackoverflow 1732454`)
    #puts(md5)
    assert_equal md5, "52e9cadba02b9d4faab99c672855416b"
  end

  def test_hermeneutics
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb hermeneutics 2604`)
    #puts(md5)
    assert_equal md5, "9f63710aebd9bdbe0dfefa239d8176ff"
  end

  def test_multiple_posts
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb superuser 267569 277793 698322`)
    #puts(md5)
    assert_equal md5, "58c37156647671c7dfa51dbe0fd8c3f2"
  end    
end
