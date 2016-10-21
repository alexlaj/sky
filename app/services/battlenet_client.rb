require 'net/http'
require 'uri'
require 'json'

class BattlenetClient
  def initialize(apikey)
    @apikey = apikey
    @uri_base = 'https://us.api.battle.net/wow/'
  end

  def get_guild(realm, guild)
    uri = @uri_base +
          "guild/#{realm}/#{guild}?fields=members&locale=en_us&apikey=" +
          @apikey
    JSON.parse(perform_get(uri))
  end

  def get_character(realm, character)
    uri = @uri_base +
          "character/#{realm}/#{character}?fields=items,talents&locale=en_us&apikey=" +
          @apikey
    JSON.parse(perform_get(uri))
  end

  private

  def perform_get(uri)
    Rails.logger.info("Requesting #{uri}")
    uri = URI.parse(URI.encode(uri))
    Net::HTTP.get_response(uri).body
  end
end
