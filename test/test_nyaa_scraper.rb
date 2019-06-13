require "json"
require "minitest/autorun"
require "webmock/minitest"

require "nyaa_scraper"

WebMock.allow_net_connect!

class TestNyaaScraper < MiniTest::Test
  def setup
    @index = File.read("fixtures/index.html")
    @nyaa = NyaaScraper.new(NyaaSearch.new)

    stub_request(:get, @nyaa.uri).to_return(:body => @index)
  end

  def test_that_the_nyaa_webpage_can_be_fetched
    assert_match(/<!DOCTYPE html>/, @nyaa.html)
  end

  def test_that_the_magnet_links_can_be_extracted
    refute_empty @nyaa.magnets
  end

  def test_that_the_torrent_links_can_be_extracted
    refute_empty @nyaa.torrents
  end
end

