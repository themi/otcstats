require 'rails_helper'

RSpec.describe ExchangeRates::RbaGovAu do

  let(:channel) { double("Channel", title: "CHANNEL") }
  let(:items) {[
    double("Item", title: "AU: 0.5 USD = 1 AUD etc"),
    double("Item", title: "AU: 1.5 JPY = 1 AUD etc")
  ]}

  subject(:exchange) { described_class.new }

  context "stuff" do
    let(:from) { "USD" }

    before {
      expect(subject).to receive(:rss_feed_for) { double("RSS", items: items, channel: channel) }
    }
    it "returns the rate 0.5" do
      expect(subject.perform(from)).to include(rate: 0.5)
    end
  end

end
