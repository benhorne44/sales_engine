require 'csv'
class CustomerRepository

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def load_file(filename)
    @contents = CSV.read"#{filename}", headers: true, header_converters: :symbol
  end

  def customers
    @customers ||= load_customers
  end

  def load_customers
    @contents.collect { |row| Customer.new(row, engine) }
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

  def find_by_id(id)
    customers.find{|c| c.id == id }
  end

  def find_by_created_at(date)
    customers.find{|c| c.created_at == date }
  end

  def find_all_by_created_at(date)
    customers.find_all{|c| c.created_at == date }
  end

  def find_by_updated_at(date)
    customers.find{|c| c.updated_at == date }
  end

  def find_all_by_updated_at(date)
    customers.find_all{|c| c.updated_at == date }
  end

  def all
    customers
  end

end


