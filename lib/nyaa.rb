require "open-uri"
require "uri"
require "nokogiri"
require "transmission"

class NyaaTorrents
  attr_reader :transmission

  def initialize(args={})
    params = defaults.merge(args)

    @filter = params[:filter]
    @category = params[:category]
    @query = params[:query]
    @page = params[:page]

    @host = params[:host]
    @port = params[:port]
    @user = params[:user]
    @pass = params[:pass]

    @transmission = Transmission.new(
      :host => @host,
      :port => @port,
      :user => @user,
      :pass => @pass
    )

    @base = "https://nyaa.si"
  end

  def defaults
    { :filter => Nyaa::Filter::NoFilter,
      :category => Nyaa::Category::AllCategories,
      :query => "",
      :page => 1,

      :host => "localhost",
      :port => 9091,
      :user => "transmission",
      :pass => "transmission" }
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
    links
      .map { |link| link["href"] } \
      .select { |href| href =~ /^magnet/ }
  end

  def links
    Nokogiri::HTML(html).css(".torrent-list tr a")
  end

  def add_magnets
    magnets.each do |m|
      transmission.add_magnet m, :paused => true
    end
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
