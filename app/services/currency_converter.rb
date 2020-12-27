class CurrencyConverter
  attr_accessor :eow, :from_currency, :to_currency
  attr_accessor :rate, :rate_description

  def initialize(eow=nil, from_currency="AUD", to_currency="USD")
    @eow ||= Time.current.production_end_of_week
    @from_currency = from_currency
    if (data = get_exchange_rate(from_currency))
      @rate = data[:rate]
      @rate_description = data[:description]
    end
  end

  def perform
    unless rate.nil?
      au_records = Statistic.where(week_ending_at: eow).where(currency: from_currency)
      au_records.each do |record|
        record.original_value = rate_description
        record.value = (record.value * rate)
        record.currency = to_currency
        record.save
      end
    end
  end

  private

  def get_exchange_rate(currency_exchange=nil)
    begin
      ExchangeRates::RbaGovAu.new.perform # returns hash {:rate, :description}
    rescue => e
      nil
    end
  end
end
