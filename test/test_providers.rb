require "minitest/autorun"
require "providers"

class TestProviders < Minitest::Test
  def test_that_providers_can_be_listed
    assert_includes Provider.list, HorribleSubs
    assert_includes Provider.list, Blackjaxx
  end
end
