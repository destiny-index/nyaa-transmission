require "minitest/autorun"
require "json"
require "magnet"

class TestMagnetName < MiniTest::Test
  def setup
    @magnet_links = JSON.parse File.read("fixtures/magnets.json")
  end

  def test_x
    assert_equal "[N&D] Black Clover (TV) - 87 - VOSTFR 1080p", torrent_name(@magnet_links.first)
  end

  def torrent_name(magnet_link)
    Magnet.name(magnet_link)
  end
end
