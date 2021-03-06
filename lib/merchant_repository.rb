require 'csv'
class MerchantRepository

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def load_file(filename)
    @contents = CSV.read"#{filename}", headers: true, header_converters: :symbol
  end

  def merchants
    @merchants ||= load_merchants
  end

  def load_merchants
    @contents.collect { |row| Merchant.new(row, engine) }
  end

  def random
    merchants.sample
  end

  def find_by_name(name)
    merchants.find{|merchant| merchant.name == name} 
  end

  def find_all_by_name(name)
    merchants.find_all{|merchant| merchant.name == name} 
  end

  def find_by_id(id)
    merchants.find{|merchant| merchant.id == id} 
  end

  def find_by_created_at(date)
    merchants.find{|merchant| merchant.created_at == date}
  end

  def find_all_by_created_at(date)
    merchants.find_all{|merchant| merchant.created_at == date} 
  end

  def find_by_updated_at(date)
    merchants.find{|merchant| merchant.updated_at == date} 
  end

  def find_all_by_updated_at(date)
    merchants.find_all{|merchant| merchant.updated_at == date} 
  end

  def all
    merchants
  end

  def most_revenue(number)
    sort_merchants_by_revenue.reverse.take(number)
  end

  def sort_merchants_by_revenue
    merchants.sort_by { |merchant| merchant.subtotal }
  end

  def revenue(date)
    merchants.inject(0) {|total_revenue, merchant| total_revenue += merchant.revenue(date)}
  end

  def most_items(number)
    merchants.sort_by { |merchant| merchant.total_items_sold }.reverse[0,number]
  end

end










