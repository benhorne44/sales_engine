require 'csv'

class MerchantRepository

  def load
    contents = CSV.read "../data/merchants.csv", headers: true, header_converters: :symbol
    @formatted_merchants = []
    contents.each do |row|
      merchant_id = row[:id]
      item_id = row[:item_id]
      invoice_id = row[:invoice_id]
      quantity = row[:quantity]
      unit_price = row[:unit_price]
      created_at = row[:created_at]
      updated_at = row[:updated_at]

      @formatted_merchants.push([merchant_id, item_id, invoice_id, quantity, unit_price, created_at, updated_at])
    end
    return @contents
  end

  def all
    load
    puts @formatted_merchants

  end
end

m = MerchantRepository.new
m.all
