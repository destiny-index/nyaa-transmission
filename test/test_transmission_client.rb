require "json"
require "minitest/autorun"

require "transmission_client"
require "test_scraper_interface"

class TestTransmissionClient < Minitest::Test
  include TestScraperInterface

  def setup
    @magnet_links = JSON.parse File.read("fixtures/magnets.json")
    @torrent_links = JSON.parse File.read("fixtures/torrents.json")

    @bittorrent = TransmissionClient.new
  end

  def teardown
    @bittorrent.purge_all
  end

  def test_that_transmission_accepts_a_list_of_magnet_links
    @bittorrent.add_magnets @magnet_links

    assert_equal @magnet_links.length, @bittorrent.count
  end

  def test_that_transmission_accepts_a_list_of_torrent_links
    @bittorrent.add_torrents @torrent_links

    assert_equal @torrent_links.length, @bittorrent.count
  end

  def test_that_transmission_purges_all_torrents
    @bittorrent.add_torrents @torrent_links

    @bittorrent.purge_all
    assert_equal 0, @bittorrent.count
  end
end
