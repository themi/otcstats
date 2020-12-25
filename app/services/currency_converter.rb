class CurrencyConverter
  attr_accessor :eow

  def initialize(eow=nil, exhange_rate_filename="config/exchange_rates.yml")
    @eow ||= Time.current.production_end_of_week
  end

  def perform(from_currency="AU", to_currency="US")
    if (exchange_rate = get_exchange_rate(from_currency, to_currency))
      au_records = Statistic.where(week_ending_at: eow).where(currency: from_currency)
      au_records.each do |record|
        record.original_value = "#{record.value}#{record.currency} (rate: #{exchange_rate})"
        record.value = (record.value * exchange_rate)
        record.currency = to_currency
        record.save
      end
    end
  end

  private

  def get_exchange_rate(from_currency, to_currency)
    file_path = Rails.root.join("config","exchange_rates.yml")
    begin
      data = YAML.load_file(file_path)[:exchange_rates]
      data[from_currency.to_sym][to_currency.to_sym][:rate].to_f
    rescue => e
      puts "======================"
      puts "Exhange rate NOT FOUND - no records updated!"
      puts "----------------------"
      puts e.inspect
      puts "----------------------"
      puts data.inspect
      puts "======================"
      nil
    end
  end
end
