Gem::Specification.new do |s|
  s.name        = "nyaa-transmission"
  s.version     = "1.0.7"
  s.date        = "2019-08-14"
  s.summary     = "Search and submit anime on NyaaTorrents to Transmission"
  s.homepage    = "https://github.com/destiny-index/nyaa-transmission"
  s.authors     = ["Anthony Poon"]
  s.email       = "marquis.andras@gmail.com"
  s.files       = Dir.glob("{bin,lib}/**/*")
  s.executables = ["nyaa"]
  s.license     = "MIT"

  s.add_runtime_dependency "nokogiri", "~> 1.10"
  s.add_runtime_dependency "transmission-ng", "~> 1.0", ">= 1.0.10"
  s.add_runtime_dependency "sqlite3", "~> 1.4"

  s.add_development_dependency "rake", "~> 12.3"
  s.add_development_dependency "minitest", "~> 5.11"
  s.add_development_dependency "webmock", "~> 3.6"
end
