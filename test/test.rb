require 'minitest/autorun'
require 'digest/md5'

class TestSE2J < Minitest::Test

  def test_locked_question
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb -s stackoverflow 179123`)
    STDERR.puts(md5) if ENV['GEN_TEST']
    assert_equal md5, "bf8b6ce3f486ffe204feb8da3263ea05"
  end
  
  def test_xml_regex
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb -s stackoverflow 1732454`)
    STDERR.puts(md5) if ENV['GEN_TEST']
    assert_equal md5, "28211d2805998df77efc616a4fa7a8a8"
  end

  def test_hermeneutics
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb -s hermeneutics 2604`)
    STDERR.puts(md5) if ENV['GEN_TEST']
    assert_equal md5, "2950b19a473fa50b3645c842a779b3f1"
  end

  def test_multiple_posts
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb -s superuser 267569 277793 698322`)
    STDERR.puts(md5) if ENV['GEN_TEST']
    assert_equal md5, "4927727a5f0f2f8c1c2c07e67d3e0452"
  end

  def test_subtitle
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb -s meta 326560`)
    STDERR.puts(md5) if ENV['GEN_TEST']
    assert_equal md5, "22c03854d3242f1c8ceebcbe7b060a3d"
  end

  def test_colons_in_title
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb -s stackoverflow 2846230`)
    STDERR.puts(md5) if ENV['GEN_TEST']
    assert_equal md5, "e5295b7bd609e1793759637e911429ec"
  end
  
  def test_custom_tags
    md5 = Digest::MD5.hexdigest(`ruby se2jekyll.rb -s stackoverflow 55885729 -t locked`)
    STDERR.puts(md5) if ENV['GEN_TEST']
    assert_equal md5, "ded43212149a6561a1e03130521c57b5"
  end
end
