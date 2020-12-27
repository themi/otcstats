require 'rss'
require 'open-uri'

module ExchangeRates
  class RbaGovAu
    def perform(convert_to="USD")

      feed = rss_feed_for(rss_url)

      au_data = feed.items.select { |item| item.title.match(/ #{convert_to} = 1 AUD/) }.first
      unless au_data.nil?
        m = au_data.title.match(/ (?<rate>\d*\.?\d*)/)
        { rate: m[:rate].to_f, description: au_data.title }
      end
    end

    private

    def rss_feed_for(url)
      uri = URI(url)
      uri.open do |rss|
        RSS::Parser.parse(rss)
      end
    end

    def rss_url
      ENV.fetch("RSS_RBA_GOV_AU")
    end

  end
end
