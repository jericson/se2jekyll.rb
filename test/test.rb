require 'minitest/autorun'
require 'digest/md5'

class TestSE2J < Minitest::Test

  def test_locked_question
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb -s stackoverflow 179123`)
    STDERR.puts(md5) if ENV['GEN_TEST']
    assert_equal md5, "4f0d4c2320bd56d1bb99c508bd39a9db"
  end
  
  def test_xml_regex
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb -s stackoverflow 1732454`)
    STDERR.puts(md5) if ENV['GEN_TEST']
    assert_equal md5, "2ad39dea30d7cb6aff0ce7d30f489a5d"
  end

  def test_hermeneutics
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb -s hermeneutics 2604`)
    STDERR.puts(md5) if ENV['GEN_TEST']
    assert_equal md5, "6f5cfab5d8f712e75c1b27b577993fc2"
  end

  def test_multiple_posts
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb -s superuser 267569 277793 698322`)
    STDERR.puts(md5) if ENV['GEN_TEST']
    assert_equal md5, "ded93c15f7a955134dab2d18fd5bcd74"
  end    
end
