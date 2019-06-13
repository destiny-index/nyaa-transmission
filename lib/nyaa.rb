require "transmission"
require "nyaa_search"
require "nyaa_scraper"
require "forwardable"

class NyaaTorrents
  extend Forwardable
  def_delegators :@scraper, :magnets, :torrents

  def initialize(args={})
    search = NyaaSearch.new(args)
    @scraper = NyaaScraper.new(search)

    @host = args[:host] || "localhost"
    @port = args[:port] || 9091
    @user = args[:user] || "transmission"
    @pass = args[:pass] || "transmission"
  end

  def add_magnets
    magnets.each do |m|
      transmission.add_magnet m, :paused => true
    end
  end

  def add_torrents
    torrents.each do |t|
      transmission.add_torrentfile t, :paused => true
    end
  end

  def transmission
    @transmission ||= Transmission.new(
      :host => @host,
      :port => @port,
      :user => @user,
      :pass => @pass
    )
  end
end
