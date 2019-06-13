require "json"
require "minitest/autorun"

require "bittorrent_client"
require "test_scraper_interface"

class TestBitTorrentClient < Minitest::Test
  include TestScraperInterface

  def setup
    @magnet_links = JSON.parse File.read("fixtures/magnets.json")
    @torrent_links = JSON.parse File.read("fixtures/torrents.json")

    @scraper = NyaaScraper.new nil
    @bittorrent = BitTorrentClient.new @scraper
  end

  def teardown
    @bittorrent.transmission.list.each do |t|
      @bittorrent.transmission.delete(t["id"], true)
    end
  end

  def test_that_transmission_accepts_a_list_of_magnet_links
    @scraper.stub :magnets, @magnet_links do
      @bittorrent.add_magnets
    end

    assert_equal @magnet_links.length, @bittorrent.transmission.list.length
  end

  def test_that_transmission_accepts_a_list_of_torrent_links
    @scraper.stub :torrents, @torrent_links do
      @bittorrent.add_torrents
    end

    assert_equal @torrent_links.length, @bittorrent.transmission.list.length
  end
end
