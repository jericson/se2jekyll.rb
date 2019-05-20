require 'minitest/autorun'
require 'digest/md5'

class TestSE2J < Minitest::Test

  def test_locked_question
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb -s stackoverflow 179123`)
    STDERR.puts(md5) if ENV['GEN_TEST']
    assert_equal md5, "23f8f2a2cb679b00dbb94b5bd7b6cb2e"
  end
  
  def test_xml_regex
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb -s stackoverflow 1732454`)
    STDERR.puts(md5) if ENV['GEN_TEST']
    assert_equal md5, "3582001fd0313f6d2d05379fe78e5b03"
  end

  def test_hermeneutics
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb -s hermeneutics 2604`)
    STDERR.puts(md5) if ENV['GEN_TEST']
    assert_equal md5, "f9582950cdccd2b2f1aa7d8211099a65"
  end

  def test_multiple_posts
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb -s superuser 267569 277793 698322`)
    STDERR.puts(md5) if ENV['GEN_TEST']
    assert_equal md5, "85227563f4a143f57720aaeea110e077"
  end    
end
