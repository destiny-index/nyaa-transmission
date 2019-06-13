module TestScraperInterface
  def test_that_scraper_responds_to_magnets_method
    @scraper.respond_to? :magnets
  end

  def test_that_scraper_responds_to_torrents_method
    @scraper.respond_to? :torrents
  end
end
