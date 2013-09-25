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
  
  def find_by(attribute, criteria)
    format_merchant_data_into_hash
    @results = []
    @merchants.each do |merchant|
      if merchant[attribute].downcase == criteria.downcase
      @results.push merchant
      end
    end
    return @results
  end

  def find_by_merchant_name(name)
    [] << find_by("merchant_name", name).first
  end

  def find_all_by_merchant_name(name)
    find_by("merchant_name", name)
  end

  def find_by_merchant_id(id)
    [] << find_by("merchant_id", id).first
  end

  def find_by_merchant_created_at(date)
    [] << find_by('merchant_created_at', date).first
  end

  def find_all_by_merchant_created_at(date)
    find_by('merchant_created_at', date)
  end

  def find_by_merchant_updated_at(date)
    [] << find_by('merchant_updated_at', date).first
  end

  def find_all_by_merchant_updated_at(date)
    find_by('merchant_updated_at', date)
  end

  def all
    format_merchant_data_into_hash
  end
end
