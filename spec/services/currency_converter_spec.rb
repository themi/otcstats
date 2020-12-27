require 'rails_helper'

RSpec.describe CurrencyConverter do

  subject(:converter) { described_class.new(eow, from_currency, to_currency) }

  let(:eow) { Time.current.to_date }
  let(:from_currency) { "XYZ" }
  let(:to_currency) { "ABC" }
  let(:exchange_data) {{ rate: 0.5, rate_description: "XYZ DESCRIPTION" }}
  let!(:stat) { create(:statistic, value: 100, currency: from_currency, week_ending_at: eow) }

  it "converts to new currency" do
    expect(ExchangeRates::RbaGovAu).to receive(:new) { double("Exchange", perform: exchange_data) }
    converter.perform
    stat.reload
    expect(stat.currency).to eq to_currency
  end

end
