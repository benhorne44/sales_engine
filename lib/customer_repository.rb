require 'csv'
class CustomerRepository

  def load_file(filename='')
    if filename == ''
      filename = './data/customers_test.csv'
    end
    @contents = CSV.read"#{filename}", headers: true, header_converters: :symbol
    return @contents
  end

  def customers
    @customers ||= load_customers
  end

  def load_customers
    load_file.collect do |row|
      Customer.new(row)
    end
  end

  def random
    customers.sample
  end

  def find_by_first_name(name)
    customers.find{|customer| customer.first_name == name }
  end

  def find_all_by_first_name(name)
    customers.find_all {|c| c.first_name == name }
  end

  def find_by_last_name(name)
    customers.find{|c| c.last_name == name }
  end

  def find_all_by_last_name(name)
    customers.find_all{|c| c.last_name == name }
  end

  def find_by_customer_id(id)
    customers.find{|c| c.id == id }
  end

  def find_by_customer_created_at(date)
    customers.find{|c| c.created_at == date }
  end

  def find_all_by_customer_created_at(date)
    customers.find_all{|c| c.created_at == date }
  end

  def find_by_customer_updated_at(date)
    customers.find{|c| c.updated_at == date }
  end

  def find_all_by_customer_updated_at(date)
    customers.find_all{|c| c.updated_at == date }
  end

  def all
    customers
  end

end


