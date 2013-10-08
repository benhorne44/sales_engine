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
    invoices_by_customer_id[id].first
  end

  def find_all_by_customer_id(id)
    invoices_by_customer_id[id]
  end

  def find_by_merchant_id(id)
    invoices_by_merchant_id[id].first
  end

  def find_all_by_merchant_id(id)
    invoices_by_merchant_id[id]
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
    invoices.max_by {|invoice| invoice.id}.id + 1
  end

  def invoices_by_customer_id
    @invoices_by_customer_id ||= invoices.group_by {|invoice| invoice.customer_id}
  end

  def invoices_by_merchant_id
    @invoices_by_merchant_id ||= invoices.group_by {|invoice| invoice.merchant_id}
  end

  def format_hash_data(invoice_data)
    { 
      id: invoice_data[:id],
      customer_id: invoice_data[:customer].id, 
      merchant_id: invoice_data[:merchant].id,
      status: invoice_data[:status],
      created_at: Time.now.utc,
      updated_at: Time.now.utc,
    }
  end

  def create_invoice_items_for_invoice(invoice_data, new_invoice)
    engine.invoice_item_repository.create(invoice_data, new_invoice)
  end

  def update_items_for_new_invoice(new_invoice, items)
    items.each {|item| new_invoice.items.push(item) }
  end

  def create(invoice_data)
    invoice_data[:id] = last_invoice_id + 1
    new_invoice = Invoice.new(format_hash_data(invoice_data), engine)
    invoices.push(new_invoice)
    create_invoice_items_for_invoice(invoice_data, new_invoice)
    update_items_for_new_invoice(new_invoice, invoice_data[:items])
    return new_invoice
  end

end
