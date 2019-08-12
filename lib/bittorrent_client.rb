require "transmission"

class BitTorrentClient
  attr_accessor :host, :port, :user, :pass

  def initialize(args={})
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

  def add_magnets(magnets) 
    magnets.each do |m|
      transmission.add_magnet m, :paused => true
    end
  end

  def add_torrents(torrents)
    torrents.each do |t|
      transmission.add_torrentfile t, :paused => true
    end
  end

  def purge_all
    transmission.list.each do |t|
      transmission.delete(t["id"], true)
    end
  end
end
