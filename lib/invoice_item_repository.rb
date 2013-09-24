require 'csv'
class InvoiceItemRepository

  def load_file(filename='')
    if filename == ''
      filename = '../data/invoice_items.csv'
    end
    @contents = CSV.read"#{filename}", headers: true, header_converters: :symbol
    return @contents
  end

  def format_invoice_item_data_into_hash
    headers = ['invoice_item_id', 'item_id', 'invoice_id', 'item_quantity', 'unit_price', 'created_at', 'updated_at']
    @invoice_items = []
    @contents.each do |row|
      invoice_item_id = row[:id]
      item_id = row[:item_id]
      invoice_id = row[:invoice_id]
      item_quantity = row[:quantity]
      unit_price = row[:unit_price]
      created_at = row[:created_at]
      updated_at = row[:updated_at]

      invoice_item_data = [invoice_item_id, item_id, invoice_id, item_quantity, unit_price, created_at, updated_at]
      invoice_item = Hash[headers.zip(invoice_item_data)]
      @invoice_items.push invoice_item
    end
    return @invoice_items
  end

  def random
    format_invoice_item_data_into_hash
    @invoice_items.sample
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
