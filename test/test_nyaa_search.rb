require "minitest/autorun"

require "nyaa_search"

class TestNyaaSearch < MiniTest::Test
  def test_that_the_query_string_contains_the_filter
    nyaa = NyaaSearch.new :filter => Nyaa::Filter::TrustedOnly

    assert_match "f=2", nyaa.querystring
  end

  def test_that_the_query_string_contains_the_category
    nyaa = NyaaSearch.new :category =>
      Nyaa::Category::Anime::EnglishTranslated

    assert_match "c=1_2", nyaa.querystring
  end

  def test_that_the_query_string_contains_the_search_query
    nyaa = NyaaSearch.new :query => "HorribleSubs 1080p"

    assert_match "q=HorribleSubs+1080p", nyaa.querystring
  end

  def test_that_the_query_string_contains_the_page_number
    nyaa = NyaaSearch.new :page => 2

    assert_match "p=2", nyaa.querystring
  end

  def test_that_the_query_string_contains_the_user
    nyaa = NyaaSearch.new :user => "Erai-raws"

    assert_match "u=Erai-raws", nyaa.querystring
  end

  def test_that_the_query_string_does_not_contain_missing_user
    nyaa = NyaaSearch.new

    refute_match "&u", nyaa.querystring
  end
end

