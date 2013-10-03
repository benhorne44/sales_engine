require 'csv'
class InvoiceRepository

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end
  
  def load_file(filename)
    @contents = CSV.read"#{filename}", headers: true, header_converters: :symbol
    return @contents
  end

  def invoices
    @invoices ||= load_invoices
  end

  def load_invoices
    @contents.collect { |row| Invoice.new(row, engine) }
  end

  def random
    invoices.sample
  end

  def find_by_id(id)
    invoices.find{|invoice| invoice.id == id}
  end

  def find_by_customer_id(id)
    invoices.find{|invoice| invoice.customer_id == id}
  end

  def find_all_by_customer_id(id)
    invoices.find_all{|invoice| invoice.customer_id == id}
  end

  def find_by_merchant_id(id)
    invoices.find{|invoice| invoice.merchant_id == id}
  end

  def find_all_by_merchant_id(id)
    invoices.find_all{|invoice| invoice.merchant_id == id}
  end

  def find_all_by_status(status)
    invoices.find_all{|invoice| invoice.status == status}
  end

  def find_by_status(status)
    invoices.find{|invoice| invoice.status == status}
  end

  def find_by_invoice_created_at(date)
    invoices.find{|invoice| invoice.created_at == date}
  end

  def find_all_by_invoice_created_at(date)
    invoices.find_all{|invoice| invoice.created_at == date}
  end

  def find_by_invoice_updated_at(date)
    invoices.find{|invoice| invoice.updated_at == date}
  end

  def find_all_by_invoice_updated_at(date)
    invoices.find_all{|invoice| invoice.updated_at == date}

  end

  def all
    invoices
  end

  def last_invoice_id
    sorted_id_values = invoices.sort_by { |invoice| -invoice.id }
    return sorted_id_values[0].id  
  end

  # def new_invoice_item
  #   {id: , item_id:, invoice_id:, quantity:, unit_price:, created_at:, updated_at: }
  # end

  def new_invoice_item_id
    sorted_id_values = engine.invoice_item_repository.all.sort_by { |invoice_item| -invoice_item.id }
    return sorted_id_values[0].id 
  end

  def format_invoice_item_data(hash, invoice)
    q = []
    formatted_data_hashes = hash[:items].each do |item|
      created_id = new_invoice_item_id + 1
      item_id = item.id
      invoice_id = invoice.id
      quantity = hash[:items].select { |items| items.id == item.id }.count
      unit_price = item.unit_price
      created_at = Time.now
      updated_at = Time.now

      headers = [:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at]
      invoice_item = [created_id, item_id, invoice_id, quantity, unit_price, created_at, updated_at]
      
      new_invoice_item_hash = Hash[headers.zip(invoice_item)]

      new_invoice_item = InvoiceItem.new(new_invoice_item_hash, engine)
      unless engine.invoice_item_repository.find_by_item_id(new_invoice_item.item_id)
        engine.invoice_item_repository.all.push(new_invoice_item)
        q.push(new_invoice_item) 
      end
    end
    return q.count
  end

  def format_hash_data(hash)
    customer = hash[:customer]
    merchant = hash[:merchant]
    status = hash[:status]
    created_id = last_invoice_id + 1
    headers = [:id, :customer_id, :merchant_id, :status, :created_at, :updated_at]
    invoice = [created_id, customer.id, merchant.id, status ||= 'shipped', Time.now, Time.now ]
    
    new_invoice = Hash[headers.zip(invoice)]
    return new_invoice
  end

  def create(hash)
    new_invoice_data = format_hash_data(hash)
    new_invoice = Invoice.new(new_invoice_data, engine)
    invoices.push(new_invoice)
    format_invoice_item_data(hash, new_invoice)
    return new_invoice
  end

end
