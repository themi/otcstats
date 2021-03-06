require 'rails_helper'

RSpec.describe ExchangeRates::RbaGovAu do

  let(:channel) { double("Channel", title: "CHANNEL") }
  let(:items) {[
    double("Item", title: "AU: 0.5 USD = 1 AUD etc", description: "AUD/USD", date: "2020-12-24"),
    double("Item", title: "AU: 1.5 JPY = 1 AUD etc", description: "AUD/JPY", date: "2020-12-24")
  ]}

  subject(:exchange) { described_class.new }

  context "with USD" do
    let(:from) { "USD" }

    before {
      expect(subject).to receive(:rss_feed_for) { double("RSS", items: items, channel: channel) }
    }
    it "returns the rate 0.5" do
      expect(subject.perform(from)).to include(rate: 0.5)
    end
  end

end
