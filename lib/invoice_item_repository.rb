require 'csv'
class InvoiceItemRepository

  def load_file(filename='')
    if filename == ''
      filename = './data/invoice_items.csv'
    end
    @contents = CSV.read"#{filename}", headers: true, header_converters: :symbol
    return @contents
  end

  def format_invoice_item_data_into_hash
    headers = ['invoice_item_id', 'item_id', 'invoice_id', 'item_quantity', 'unit_price', 'invoice_item_created_at', 'invoice_item_updated_at']
    @invoice_items = []
    @contents.each do |row|
      invoice_item_id = row[:id]
      item_id = row[:item_id]
      invoice_id = row[:invoice_id]
      item_quantity = row[:quantity]
      unit_price = row[:unit_price]
      invoice_item_created_at = row[:created_at]
      invoice_item_updated_at = row[:updated_at]

      invoice_item_data = [invoice_item_id, item_id, invoice_id, item_quantity, unit_price, invoice_item_created_at, invoice_item_updated_at]
      invoice_item = Hash[headers.zip(invoice_item_data)]
      @invoice_items.push invoice_item
    end
    return @invoice_items
  end

  def random
    format_invoice_item_data_into_hash
    @invoice_items.sample
  end

  def find_by(attribute, criteria)
    format_invoice_item_data_into_hash
    @results = []
    @invoice_items.each do |invoice_item|
      if invoice_item[attribute] == criteria
      @results.push invoice_item
      end
      break
    end
    return @results
  end

  def find_all_by(attribute, criteria)
    format_invoice_item_data_into_hash
    @results = []
    @invoice_items.each do |invoice_item|
      if invoice_item[attribute] == criteria
      @results.push invoice_item
      end
    end
    return @results
  end

  def find_by_item_id(id)
    find_by("item_id", id)
  end

  def find_all_by_item_id(id)
    find_all_by("item_id", id)
  end

  def find_by_invoice_item_id(id)
    find_all_by('invoice_item_id', id)
  end

  def find_all_by_quantity(input)
    find_all_by('item_quantity', input)
  end

  def find_by_quantity(input)
    find_by("item_quantity", input)
  end

  def find_by_unit_price(input)
    find_by("unit_price", input)
  end

  def find_all_by_unit_price(input)
    find_all_by("unit_price", input)
  end

  def find_by_invoice_item_created_at(date)
    find_by('invoice_item_created_at', date)
  end

  def find_all_by_invoice_item_created_at(date)
    find_all_by('invoice_item_created_at', date)
  end

  def find_by_invoice_item_updated_at(date)
    find_by('invoice_item_updated_at', date)
  end

  def find_all_by_invoice_item_updated_at(date)
    find_all_by('invoice_item_updated_at', date)
  end

end
