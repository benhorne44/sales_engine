require 'csv'


class InvoiceItemRepository

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def load_file(filename='')
    if filename == ''
      filename = './data/invoice_items.csv'
    end
    @contents = CSV.read"#{filename}", headers: true, header_converters: :symbol
    return @contents
  end

  def invoice_items
    @invoice_items ||= load_invoice_items
  end

  def load_invoice_items
    load_file.collect { |row| InvoiceItem.new(row, engine) }
  end
  
  def random
    invoice_items.sample
  end

  def find_by_item_id(id)
    invoice_items.find{|i| i.item_id == id }
  end

  def find_all_by_item_id(id)
    invoice_items.find_all{|i| i.item_id == id }
  end

  def find_all_by_invoice_id(id)
    invoice_items.find_all{|i| i.invoice_id == id }
  end

  def find_by_invoice_item_id(id)
    invoice_items.find{|i| i.id == id }
  end

  def find_all_by_quantity(quantity)
    invoice_items.find_all{|i| i.quantity == quantity }
  end

  def find_by_quantity(quantity)
    invoice_items.find{|i| i.quantity == quantity }
  end

  def find_by_unit_price(price)
    invoice_items.find{|i| i.unit_price == price }
  end

  def find_all_by_unit_price(price)
    invoice_items.find_all{|i| i.unit_price == price }
  end

  def find_by_invoice_item_created_at(date)
    invoice_items.find{|i| i.created_at == date }
  end

  def find_all_by_invoice_item_created_at(date)
    invoice_items.find_all{|i| i.created_at == date }
  end

  def find_by_invoice_item_updated_at(date)
    invoice_items.find{|i| i.updated_at == date }
  end

  def find_all_by_invoice_item_updated_at(date)
    invoice_items.find_all{|i| i.updated_at == date }
  end

  def all
    invoice_items
  end


end
