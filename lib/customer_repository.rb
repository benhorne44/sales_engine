require 'csv'
class CustomerRepository
  # def initialize
  #   load_file
  # end
  def load_file(filename='')
    if filename == ''
      filename = './data/customers.csv'
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

  def find_by(attribute, criteria)
    format_customer_into_hash
    @results = []
    @customers.each do |customer|
      if customer[attribute].downcase == criteria.downcase
      @results.push customer
      end
    end
    return @results
  end

  def find_by_first_name(name)
    [] << find_by("customer_first_name", name).first
  end

  def find_all_by_first_name(name)
    find_by("customer_first_name", name)
  end

  def find_by_last_name(name)
    [] << find_by("customer_last_name", name).first
  end

  def find_all_by_last_name(name)
    find_by("customer_last_name", name)
  end

  def find_by_customer_id(id)
    [] << find_by("customer_id", id).first
  end

  def find_by_customer_created_at(date)
    [] << find_by('customer_created_at', date).first
  end

  def find_all_by_customer_created_at(date)
    find_by('customer_created_at', date)
  end

  def find_by_customer_updated_at(date)
    [] << find_by('customer_updated_at', date).first
  end

  def find_all_by_customer_updated_at(date)
    find_by('customer_updated_at', date)
  end

end


