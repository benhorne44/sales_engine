require 'csv'
class CustomerRepository
  # def initialize
  #   load_file
  # end
  def load_file(filename='')
    if filename == ''
      filename = '../data/customers.csv'
    end
    @contents = CSV.read"#{filename}", headers: true, header_converters: :symbol
    return @contents
  end

  def format_customer_into_hash
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

  def find_all_by_first_name(input)
    format_customer_into_hash
    @results = []
    @customers.each do |customer|
      if customer["customer_first_name"] == input
      # if customer.find{|key, hash| key == "customer_first_name" && hash == input}
       @results.push customer
      end
    end
    return @results
  end

  def find_by_first_name(input)
    format_customer_into_hash
    @results = []
    @customers.each do |customer|
      if customer.find{|key, hash| key == "customer_first_name" && hash == input}
      @results.push customer
      break
      end
    end
    return @results
  end

  def find_all_by_last_name(input)
    format_customer_into_hash
    @results = []
    @customers.each do |customer|
     if customer.find{|key, hash| key == "customer_last_name" && hash == input}
     @results.push customer
     end
    end
    return @results
  end

  def find_by_last_name(input)
    format_customer_into_hash
    @results = []
    @customers.each do |customer|
      if customer.find{|key, hash| key == "customer_last_name" && hash == input}
      @results.push customer
      break
      end
    end
    return @results
  end

  def find_by_id(input)
    format_customer_into_hash
    @results = []
    @customers.each do |customer|
      if customer.find{|key, hash| key == "id" && hash == input}
      @results.push customer
      end
    end
    return @results
  end

  def create_customer_object
    Customer.new(hash)
  end
end
