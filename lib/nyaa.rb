require "nyaa_search"
require "nyaa_scraper"
require "bittorrent_client"

class NyaaTorrents
  def initialize(args={})
    search = NyaaSearch.new(args)
    scraper = NyaaScraper.new(search)
    @bittorrent = BitTorrentClient.new(scraper, args)
  end
end
