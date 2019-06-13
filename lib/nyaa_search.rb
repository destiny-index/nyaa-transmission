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

class NyaaSearch
  attr_accessor :filter, :category, :query, :page

  def initialize(args={})
    self.filter = args[:filter] ||  Nyaa::Filter::NoFilter
    self.category = args[:category] || Nyaa::Category::AllCategories
    self.query = args[:query] || ""
    self.page = args[:page] || 1
  end

  def querystring
    URI.encode_www_form(
      "f" => self.filter,
      "c" => self.category,
      "q" => self.query,
      "p" => self.page
    )
  end
end
