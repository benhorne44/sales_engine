require 'csv'
class MerchantRepository

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def load_file(filename='')
    if filename == ''
      filename = './data/merchants.csv'
    end
    @contents = CSV.read"#{filename}", headers: true, header_converters: :symbol
    return @contents
  end

  def merchants
    @merchants ||= load_merchants
  end

  def load_merchants
    load_file.collect { |row| Merchant.new(row, engine) }
  end

  def random
    merchants.sample
  end

  def find_by_merchant_name(name)
    merchants.find{|merchant| merchant.name == name} 
  end

  def find_all_by_merchant_name(name)
    merchants.find_all{|merchant| merchant.name == name} 
  end

  def find_by_merchant_id(id)
    merchants.find{|merchant| merchant.id == id} 
  end

  def find_by_merchant_created_at(date)
    merchants.find{|merchant| merchant.created_at == date}
  end

  def find_all_by_merchant_created_at(date)
    merchants.find_all{|merchant| merchant.created_at == date} 
  end

  def find_by_merchant_updated_at(date)
    merchants.find{|merchant| merchant.updated_at == date} 
  end

  def find_all_by_merchant_updated_at(date)
    merchants.find_all{|merchant| merchant.updated_at == date} 
  end

  def all
    merchants
  end

end
