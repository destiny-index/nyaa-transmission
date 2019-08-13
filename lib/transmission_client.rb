require "transmission"
require "sqlite3"

class TransmissionClient
  def initialize(args={})
    @host = args[:host] || "localhost"
    @port = args[:port] || 9091
    @user = args[:user] || "transmission"
    @pass = args[:pass] || "transmission"
    @db = args[:db] || ":memory:"

    @sqlite = SQLite3::Database.new @db
    @sqlite.execute <<~SQL
      CREATE TABLE IF NOT EXISTS links (
        id INTEGER PRIMARY KEY,
        link TEXT UNIQUE,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    SQL
  end

  def add_magnets(magnets)
    magnets.each do |m|
      record_link m
      transmission.add_magnet m, :paused => true
    rescue SQLite3::ConstraintException
      next
    end
  end

  def add_torrents(torrents)
    torrents.each do |t|
      record_link t
      transmission.add_torrentfile t, :paused => true
    rescue SQLite3::ConstraintException
      next
    end
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
    sqlite.get_first_value "SELECT COUNT(id) FROM links"
  end

  private

    def transmission
      @transmission ||= Transmission.new(
        :host => @host,
        :port => @port,
        :user => @user,
        :pass => @pass
      )
    end

    def sqlite
      @sqlite
    end

    def record_link(link)
      sqlite.execute "INSERT INTO links ( link ) VALUES ( ? )", link
    end

    def list_all
      transmission.list
    end

end
