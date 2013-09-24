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

  # def find_by_name
  #   format_customer_into_hash
  #   @customers.each do |attendee|
  #     if customer
        
  #     end
  #   end
  # end

  # def create_customer_object
  #   Customer.new(hash)
  # end
end
