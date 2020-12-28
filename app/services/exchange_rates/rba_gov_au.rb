require 'rss'
require 'open-uri'

module ExchangeRates
  class RbaGovAu
    def perform(convert_to="USD")
      feed = rss_feed_for(rss_url)
      au_item = feed.items.select { |item| item.description.match(/^AUD\/#{convert_to}/) }.first
      unless au_item.nil?
        m = au_item.title.match(/^AU: (?<rate>\d*\.?\d*)/)
        {
          rate: m[:rate].to_f,
          description: "rate #{m[:rate]} as at #{au_item.date}"
        }
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
