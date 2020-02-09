require "minitest"
require "providers"

class TestHorribleSubs < MiniTest::Test
  def test_that_anime_from_horrible_subs_can_be_found
    found = HorribleSubs.search_for("one punch man s2")
    num_episodes = 12
    assert_equal num_episodes, found.length
  end
end
