require "json"
require "minitest/autorun"

require "nyaa"

class TestTransmissionClient < Minitest::Test
  def setup
    @magnet_links = JSON.parse File.read("fixtures/magnets.json")
    @torrent_links = JSON.parse File.read("fixtures/torrents.json")
    @nyaa = NyaaTorrents.new
  end

  def teardown
    @nyaa.transmission.list.each do |t|
      @nyaa.transmission.delete(t["id"], true)
    end
  end

  def test_that_transmission_accepts_a_list_of_magnet_links
    @nyaa.stub :magnets, @magnet_links do
      @nyaa.add_magnets
    end

    assert_equal @magnet_links.length, @nyaa.transmission.list.length
  end

  def _test_that_transmission_accepts_a_list_of_torrent_links
    @nyaa.stub :torrents, @torrent_links do
      @nyaa.add_torrents
    end

    assert_equal @torrent_links.length, @nyaa.transmission.list.length
  end
end
