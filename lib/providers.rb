require "objspace"
require "nyaa_search"
require "nyaa_scraper"

class Provider
  def self.list
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end
end

class HorribleSubs < Provider
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

class EraiRaws < Provider
  def self.search_for(series)
    search_criteria = NyaaSearch.new(
      :filter => Nyaa::Filter::TrustedOnly,
      :category => Nyaa::Category::Anime::EnglishTranslated,
      :query => "Erai-raws 1080p -batch #{series}",
      :page => 1
    )

    scraper = NyaaScraper.new(search_criteria)
    return scraper.magnets
  end
end

class Blackjaxx < Provider
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
