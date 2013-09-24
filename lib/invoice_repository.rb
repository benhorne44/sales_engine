require 'csv'
class InvoiceRepository
  # def initialize(filename)
  #   load_file
  # end

  def load_file(filename='')
    if filename == ''
      filename = '../data/invoices.csv'
    end
    @contents = CSV.read"#{filename}", headers: true, header_converters: :symbol
    return @contents
  end

  def format_invoice_data_into_hash
    headers = ['invoice_id', 'customer_id', 'merchant_id', 'invoice_status', 'invoice_created_at', 'invoice_updated_at']
    @invoices = []
    @contents.each do |row|
      invoice_id = row[:id]
      customer_id = row[:customer_id]
      merchant_id = row[:merchant_id]
      invoice_status = row[:status]
      invoice_created_at = row[:created_at]
      invoice_updated_at = row[:updated_at]

      invoice_data = [invoice_id, customer_id, merchant_id, invoice_status, invoice_created_at, invoice_updated_at]
      invoice = Hash[headers.zip(invoice_data)]
      @invoices.push invoice
    end
    return @invoices
  end

  def random
    format_invoice_data_into_hash
    @invoices.sample
  end

  # def find_by_name
  #   format_invoice_data_into_hash
  #   @invoices.each do |invoice|
  #     if invoice
        
  #     end
  #   end
  # end

  # def create_customer_object
  #   Customer.new(hash)
  # end
end
