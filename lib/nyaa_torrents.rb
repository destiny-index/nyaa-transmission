require "nyaa_search"
require "nyaa_scraper"
require "transmission_client"

class NyaaTorrents
  attr_accessor :bittorrent

  def initialize(args={})
    @bittorrent = TransmissionClient.new args
  end

  def add_all_magnets(series="")
    @search = NyaaSearch.new(
      :filter => Nyaa::Filter::TrustedOnly,
      :category => Nyaa::Category::Anime::EnglishTranslated,
      :query => "HorribleSubs 1080p -batch #{series}",
      :page => 1
    )
    @scraper = NyaaScraper.new @search

    @bittorrent.add_magnets @scraper.magnets
  end

  def purge_all
    @bittorrent.purge_all
  end
end
