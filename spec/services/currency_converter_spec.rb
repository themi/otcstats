require 'rails_helper'

RSpec.describe CurrencyConverter do

  subject(:converter) { described_class.new(eow, from_currency, to_currency) }

  let(:eow) { Time.current.to_date }
  let(:from_currency) { "XYZ" }
  let(:to_currency) { "ABC" }
  let(:exchange_data) {{ rate: 0.5, rate_description: "XYZ DESCRIPTION" }}
  let!(:stat) { create(:statistic, value: 100, currency: from_currency, week_ending_at: eow) }

  context "with successful call to Exchange" do
    before {
      expect(ExchangeRates::RbaGovAu).to receive(:new) { double("Exchange", perform: exchange_data) }
    }
    it "converts to new currency" do
      converter.perform
      stat.reload
      expect(stat.currency).to eq to_currency
    end
  end

  context "with unsuccessful call to Exchange" do
    before {
      expect(ExchangeRates::RbaGovAu).to receive(:new) { raise "Error" }
    }
    it "skips convert to new currency" do
      converter.perform
      stat.reload
      expect(stat.currency).to eq from_currency
    end
  end
end
