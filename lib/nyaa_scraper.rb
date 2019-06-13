require "nokogiri"
require "open-uri"
require "uri"

class NyaaScraper
  attr_accessor :base

  def initialize(search)
    @search = search
    self.base = "https://nyaa.si"
  end

  def uri
    URI.join self.base, "?#{@search.querystring}"
  end

  def html
    uri.read
  end

  def links
    Nokogiri::HTML(html)\
      .css(".torrent-list tr a") \
      .map { |link| link["href"] }
  end

  def magnets
    links.select { |href| href =~ /^magnet/ }
  end

  def torrents
    links.select { |href| href =~ /\.torrent$/ } \
      .map { |href| URI.join self.base, "#{href}" } \
      .map { |uri| uri.to_s }
  end
end

