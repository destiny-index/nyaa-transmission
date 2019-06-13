require "open-uri"
require "uri"
require "nokogiri"
require "transmission"
require "nyaa_search"
require "forwardable"

class NyaaTorrents
  extend Forwardable
  def_delegators :@search, :querystring

  def initialize(args={})
    @search = NyaaSearch.new(args)

    @host = args[:host] || "localhost"
    @port = args[:port] || 9091
    @user = args[:user] || "transmission"
    @pass = args[:pass] || "transmission"

    @base = "https://nyaa.si"
  end

  def html
    uri.read
  end

  def uri
    URI.join @base, "?#{querystring}"
  end

  def magnets
    links.select { |href| href =~ /^magnet/ }
  end

  def torrents
    links.select { |href| href =~ /\.torrent$/ } \
      .map { |href| URI.join @base, "#{href}" } \
      .map { |uri| uri.to_s }
  end

  def links
    Nokogiri::HTML(html)\
      .css(".torrent-list tr a") \
      .map { |link| link["href"] }
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
