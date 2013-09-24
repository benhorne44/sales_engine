require 'csv'
class MerchantRepository
  # def initialize
  #   load_file
  # end
  def load_file(filename='')
    if filename == ''
      filename = '../data/merchants.csv'
    end
    @contents = CSV.read"#{filename}", headers: true, header_converters: :symbol
    return @contents
  end

  def format_merchant_data_into_hash
    # load_file
    headers = ['merchant_id', 'merchant_name', 'merchant_created_at', 'merchant_updated_at']
    @merchants = []
    @contents.each do |row|
      merchant_id = row[:id]
      merchant_name = row[:name]
      merchant_created_at = row[:created_at]
      merchant_updated_at = row[:updated_at]

      merchant_data = [merchant_id, merchant_name, merchant_created_at, merchant_updated_at]
      merchant = Hash[headers.zip(merchant_data)]
      @merchants.push merchant
    end
    return @merchants
  end

  def random
    format_merchant_data_into_hash
    @merchants.sample
  end

  def find_by_name
    format_customer_into_hash
    @customers.each do |attendee|
      if customer
        
      end
    end
  end

  def create_customer_object
    Customer.new(hash)
  end
end
