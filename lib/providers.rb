require "nyaa_search"
require "nyaa_scraper"

class HorribleSubs
  def self.search_for(series)
    search_criteria = NyaaSearch.new(
      :filter => Nyaa::Filter::TrustedOnly,
      :category => Nyaa::Category::Anime::EnglishTranslated,
      :query => "HorribleSubs 1080p -batch #{series}",
      :page => 1
    )

    scraper = NyaaScraper.new(search_criteria)
    return scraper.magnets
  end
end

class Blackjaxx
  def self.search_for(series)
    search_criteria = NyaaSearch.new(
      :filter => Nyaa::Filter::NoFilter,
      :category => Nyaa::Category::Anime::EnglishTranslated,
      :query => "Blackjaxx 1080p -batch #{series}",
      :page => 1
    )

    scraper = NyaaScraper.new(search_criteria)
    return scraper.magnets
  end
end
