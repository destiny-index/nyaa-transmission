require "minitest/autorun"
require "nyaa_torrents"

class TestNyaaTorrents < Minitest::Test
  def setup
    @nyaa_torrents = NyaaTorrents.new
  end

  def teardown
    @nyaa_torrents.purge_all
  end

  def test_that_anime_magnets_are_added_to_bittorrent_client
    @nyaa_torrents.add_all_magnets "one punch man s2"
    num_episodes = 12
    assert_equal num_episodes, @nyaa_torrents.bittorrent.count
  end
end
