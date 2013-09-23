class CustomerRepository
  # def initialize
  #   load_file
  # end
  def load_file
    @contents = CSV.read'../data/customers_test.csv', headers: true, header_converters: :symbol
    return @contents
  end

  def format_customer_into_hash
    load_file
    headers = ['customer_id', 'customer_first_name', 'customer_last_name', 'customer_created_at', 'customer_updated_at']
    @customers = []
    @contents.each do |row|
      customer_id = row[:id]
      customer_first_name = row[:first_name]
      customer_last_name = row[:last_name]
      customer_created_at = row[:created_at]
      customer_updated_at = row[:updated_at]

      customer_data = [customer_id, customer_first_name, customer_last_name, customer_created_at, customer_updated_at]
      customer = Hash[headers.zip(customer_data)]
      @customers.push customer
    end
    return @customers
  end

  def random
    format_customer_into_hash
    @customers.sample
  end

  def find_by_name
    format_customer_into_hash
    @customers.each do |attendee|
      if customer[]
        
      end
  end

  def create_customer_object
    Customer.new(hash)
  end
end
