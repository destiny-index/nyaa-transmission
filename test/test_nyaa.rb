require "json"
require "minitest/autorun"
require "minitest/mock"
require "webmock/minitest"

require "nyaa"

WebMock.allow_net_connect!

class TestNyaaScraper < MiniTest::Test
  def setup
    @index = File.read("fixtures/index.html")
    @nyaa = NyaaTorrents.new
  end

  def test_that_the_nyaa_webpage_can_be_fetched
    stub_request(:get, @nyaa.uri).to_return(:body => @index)

    assert_match(/<!DOCTYPE html>/, @nyaa.html)
  end

  def test_that_the_magnet_links_can_be_extracted
    @nyaa.stub :html, @index do
      refute_empty @nyaa.magnets
    end
  end

  def test_that_the_torrent_links_can_be_extracted
    @nyaa.stub :html, @index do
      refute_empty @nyaa.torrents
    end
  end
end

class TestNyaaSearch < MiniTest::Test
  def test_that_the_query_string_contains_the_filter
    nyaa = NyaaTorrents.new :filter => Nyaa::Filter::TrustedOnly

    assert_match "f=2", nyaa.querystring
  end

  def test_that_the_query_string_contains_the_category
    nyaa = NyaaTorrents.new :category => 
      Nyaa::Category::Anime::EnglishTranslated

    assert_match "c=1_2", nyaa.querystring
  end

  def test_that_the_query_string_contains_the_search_query
    nyaa = NyaaTorrents.new :query => "HorribleSubs 1080p" 

    assert_match "q=HorribleSubs+1080p", nyaa.querystring
  end

  def test_that_the_query_string_contains_the_page_number
    nyaa = NyaaTorrents.new :page => 2

    assert_match "p=2", nyaa.querystring
  end
end

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
