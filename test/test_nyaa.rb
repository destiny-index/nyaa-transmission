require "minitest/autorun"
require "minitest/mock"
require "webmock/minitest"

require "nyaa"

class TestNyaa < MiniTest::Test
  def setup
    @index = File.read("fixtures/index.html")
  end

  def test_that_the_nyaa_webpage_can_be_fetched
    nyaa = Nyaa.new
    stub_request(:get, nyaa.uri).to_return(:body => @index)

    assert_match(/<!DOCTYPE html>/, nyaa.html)
  end

  def test_that_the_query_string_contains_the_filter
    nyaa = Nyaa.new :filter => Nyaa::Filter::TrustedOnly

    assert_match "f=2", nyaa.querystring
  end

  def test_that_the_query_string_contains_the_category
    nyaa = Nyaa.new :category => Nyaa::Category::Anime::EnglishTranslated

    assert_match "c=1_2", nyaa.querystring
  end

  def test_that_the_query_string_contains_the_search_query
    nyaa = Nyaa.new :query => "HorribleSubs 1080p" 

    assert_match "q=HorribleSubs+1080p", nyaa.querystring
  end

  def test_that_the_query_string_contains_the_page_number
    nyaa = Nyaa.new :page => 2

    assert_match "p=2", nyaa.querystring
  end

  def test_that_the_torrent_links_can_be_extracted
    nyaa = Nyaa.new

    nyaa.stub :html, @index do
      refute_empty nyaa.torrents
    end
  end
end
