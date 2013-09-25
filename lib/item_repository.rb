require 'csv'


class ItemRepository

  def load_file(filename='')
    if filename == ''
      filename = '../data/items.csv'
    end
    @contents = CSV.read"#{filename}", headers: true, header_converters: :symbol
    return @contents
  end

  def format_item_data_into_hash
    headers = ['item_id', 'item_name', 'item_description', 'unit_price', 'merchant_id', 'item_created_at', 'item_updated_at']
    @items = []
    @contents.each do |row|
      item_id = row[:id]
      item_name = row[:name]
      item_description = row[:description]
      unit_price = row[:unit_price]
      merchant_id = row[:merchant_id]
      item_created_at = row[:created_at]
      item_updated_at = row[:updated_at]

      item_data = [item_id, item_name, item_description, unit_price, merchant_id, item_created_at, item_updated_at]
      item = Hash[headers.zip(item_data)]
      @items.push item
    end
    return @items
  end

  def random
    format_item_data_into_hash
    @items.sample
  end
  def find_by(attribute, criteria)
    format_item_data_into_hash
    @results = []
    @items.each do |item|
      if item[attribute].downcase == criteria.downcase
      @results.push item
      end
    end
    return @results
  end

  def find_by_item_name(name)
    [] << find_by("item_name", name).first
  end

  def find_all_by_item_name(name)
    find_by("item_name", name)
  end

  def find_by_item_id(id)
    [] << find_by("item_id", id).first
  end

  def find_by_item_description(input)
    [] << find_by("item_description", input).first
  end

  def find_all_by_item_description(input)
    find_by("item_description", input)
  end

  def find_by_unit_price(price)
    [] << find_by("unit_price", price).first
  end

  def find_all_by_unit_price(price)
    find_by("unit_price", price)
  end

  def find_by_merchant_id(id)
    [] << find_by("merchant_id", id).first
  end

  def find_all_by_merchant_id(id)
    find_by("merchant_id", id)
  end

  def find_by_item_created_at(date)
    [] << find_by('item_created_at', date).first
  end

  def find_all_by_item_created_at(date)
    find_by('item_created_at', date)
  end

  def find_by_item_updated_at(date)
    [] << find_by('item_updated_at', date).first
  end

  def find_all_by_item_updated_at(date)
    find_by('item_updated_at', date)
  end

  def all
    format_item_data_into_hash
  end
end
