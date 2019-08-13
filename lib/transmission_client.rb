require "transmission"
require "sqlite3"

class TransmissionClient
  attr_accessor :host, :port, :user, :pass, :sqlite

  def initialize(args={})
    @host = args[:host] || "localhost"
    @port = args[:port] || 9091
    @user = args[:user] || "transmission"
    @pass = args[:pass] || "transmission"

    @sqlite = SQLite3::Database.new ":memory:"
    @sqlite.execute <<~SQL
      CREATE TABLE magnet_links (
        id INTEGER PRIMARY KEY,
        link TEXT UNIQUE,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    SQL
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
      record_magnet_link m
      transmission.add_magnet m, :paused => true
    end
  end

  def add_torrents(torrents)
    torrents.each do |t|
      transmission.add_torrentfile t, :paused => true
    end
  end

  def list_all
    transmission.list
  end

  def count
    list_all.length
  end

  def purge_all
    transmission.list.each do |t|
      transmission.delete(t["id"], true)
    end
  end

  def history
    sqlite.get_first_value "SELECT COUNT(id) FROM magnet_links"
  end

  private

    def record_magnet_link(magnet_link)
      sqlite.execute "INSERT INTO magnet_links ( link ) VALUES ( ? )", magnet_link
    end

end
