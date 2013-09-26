require 'csv'
class InvoiceRepository
 
  def load_file(filename='')
    if filename == ''
      filename = './data/invoices_test.csv'
    end
    @contents = CSV.read"#{filename}", headers: true, header_converters: :symbol
    return @contents
  end

  def invoices
    @invoices ||= load_invoices
  end

  def load_invoices
    load_file.collect do |row|
      Invoice.new(row)
    end
  end

  def random
    invoices.sample
  end

  def find_by_invoice_id(id)
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

  def find_all_by_invoice_status(status)
    invoices.find_all{|invoice| invoice.status == status}
  end

  def find_by_invoice_status(status)
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

end
