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

 def find_by(attribute, criteria)
    format_invoice_data_into_hash
    @results = []
    @invoices.each do |invoice|
      if invoice[attribute] == criteria
      @results.push invoice
      end
    end
    return @results
  end

  def find_by_invoice_id(id)
    [] << find_by("invoice_id", id).first
  end

  def find_by_customer_id(id)
    [] << find_by('customer_id', id).first
  end

   def find_all_by_customer_id(id)
    find_by('customer_id', id)
  end

  def find_by_merchant_id(id)
    [] << find_by('merchant_id', id).first
  end

  def find_all_by_merchant_id(id)
    find_by('merchant_id', id)
  end

  def find_all_by_invoice_status(input)
    find_by('invoice_status', input)
  end

  def find_by_invoice_status(input)
    [] << find_by("invoice_status", input).first
  end

  def find_by_invoice_created_at(date)
    [] << find_by('invoice_created_at', date).first
  end

  def find_all_by_invoice_created_at(date)
    find_by('invoice_created_at', date)
  end

  def find_by_invoice_updated_at(date)
    [] << find_by('invoice_updated_at', date).first
  end

  def find_all_by_invoice_updated_at(date)
    find_by('invoice_updated_at', date)
  end

  def all
    format_invoice_data_into_hash
  end

end
