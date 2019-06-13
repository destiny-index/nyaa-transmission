require "open-uri"
require "uri"
require "nokogiri"
require "transmission"

module Nyaa; end

module Nyaa::Filter
  NoFilter = "0"
  NoRemakes = "1"
  TrustedOnly = "2"
end

module Nyaa::Category
  AllCategories = "0_0"

  module Anime
    MusicVideo = "1_1"
    EnglishTranslated = "1_2"
    NonEnglishTranslated = "1_3"
    Raw = "1_4"
  end
end

class NyaaTorrents
  def initialize(args={})
    @filter = args[:filter] ||  Nyaa::Filter::NoFilter
    @category = args[:category] || Nyaa::Category::AllCategories
    @query = args[:query] || ""
    @page = args[:page] || 1

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

  def querystring
    URI.encode_www_form(
      "f" => @filter,
      "c" => @category,
      "q" => @query,
      "p" => @page
    )
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
