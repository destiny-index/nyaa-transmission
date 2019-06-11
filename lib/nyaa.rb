require "open-uri"
require "uri"
require "nokogiri"

class NyaaTorrents

  def initialize(args={})
    params = defaults.merge(args)

    @filter = params[:filter]
    @category = params[:category]
    @query = params[:query]
    @page = params[:page]

    @base = "https://nyaa.si"
  end

  def defaults
    { :filter => Nyaa::Filter::NoFilter,
      :category => Nyaa::Category::AllCategories,
      :query => "",
      :page => 1 }
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

  def torrents
    links
      .map { |link| link["href"] } \
      .select { |href| href =~ /\.torrent$/ }
  end

  def links
    Nokogiri::HTML(html).css(".torrent-list tr a")
  end
end

module Nyaa
  module Filter
    NoFilter = "0"
    NoRemakes = "1"
    TrustedOnly = "2"
  end

  module Category
    AllCategories = "0_0"

    module Anime
      MusicVideo = "1_1"
      EnglishTranslated = "1_2"
      NonEnglishTranslated = "1_3"
      Raw = "1_4"
    end
  end
end
