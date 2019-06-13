require "json"
require "minitest/autorun"
require "webmock/minitest"

require "nyaa_scraper"
require "test_scraper_interface"

WebMock.allow_net_connect!

class TestNyaaScraper < MiniTest::Test
  include TestScraperInterface

  def setup
    @index = File.read("fixtures/index.html")
    @scraper = NyaaScraper.new(NyaaSearch.new)

    stub_request(:get, @scraper.uri).to_return(:body => @index)
  end

  def test_that_the_nyaa_webpage_can_be_fetched
    assert_match(/<!DOCTYPE html>/, @scraper.html)
  end

  def test_that_the_magnet_links_can_be_extracted
    refute_empty @scraper.magnets
  end

  def test_that_the_torrent_links_can_be_extracted
    refute_empty @scraper.torrents
  end
end
