require "transmission"

class BitTorrentClient
  attr_accessor :host, :port, :user, :pass

  def initialize(scraper, args={})
    @scraper = scraper
    self.host = args[:host] || "localhost"
    self.port = args[:port] || 9091
    self.user = args[:user] || "transmission"
    self.pass = args[:pass] || "transmission"
  end

  def transmission
    @transmission ||= Transmission.new(
      :host => self.host,
      :port => self.port,
      :user => self.user,
      :pass => self.pass
    )
  end

  def add_magnets
    @scraper.magnets.each do |m|
      transmission.add_magnet m, :paused => true
    end
  end

  def add_torrents
    @scraper.torrents.each do |t|
      transmission.add_torrentfile t, :paused => true
    end
  end
end
