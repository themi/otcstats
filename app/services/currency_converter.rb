class CurrencyConverter
  attr_accessor :eow

  def initialize(eow=nil)
    @eow ||= Time.current.production_end_of_week
  end

  def perform(from_currency="AU", to_currency="US")
    exchange_rate = get_exchange_rate(from_currency, to_currency)
    au_records = Statistic.where(week_ending_at: eow).where(currency: from_currency)
    au_records.each do |record|
      record.original_value = "#{record.value}#{record.currency} (rate: #{exchange_rate})"
      record.value = (record.value * exchange_rate)
      record.currency = to_currency
      record.save
    end
  end

  private

  def get_exchange_rate(from_currency, to_currency)
    ENV.fetch("AU_US_EXCHANGE_RATE").to_f
  end
end
