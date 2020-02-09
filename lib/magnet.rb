require "uri"
require "cgi"

class Magnet
  def self.name(magnet_link)
    uri = URI.parse magnet_link
    params = CGI::parse uri.query
    params["dn"].first
  end
end
