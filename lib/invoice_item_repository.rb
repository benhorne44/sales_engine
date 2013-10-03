require 'csv'


class InvoiceItemRepository

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def load_file(filename)
    @contents = CSV.read"#{filename}", headers: true, header_converters: :symbol
    return @contents
  end

  def invoice_items
    @invoice_items ||= load_invoice_items
  end

  def load_invoice_items
    @contents.collect { |row| InvoiceItem.new(row, engine) }
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

  def find_by_id(id)
    invoice_items.find{|i| i.id == id }
  end

  def find_all_by_quantity(quantity)
    invoice_items.find_all{|i| i.quantity == quantity }
  end

  def find_by_quantity(quantity)
    invoice_items.find{|i| i.quantity == quantity }
  end

  def find_by_unit_price(price)
    price_in_cents = price*100
    invoice_items.find{|i| i.unit_price == price_in_cents.to_i }
  end

  def find_all_by_unit_price(price)
    price_in_cents = price*100
    invoice_items.find_all{|i| i.unit_price == price_in_cents.to_i }
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

  def successful_invoice_items
    invoice_items.select { |invoice_item| invoice_item.invoice.successful? }
  end

  def subtotal_per_invoice_items
    successful_invoice_items.each_with_object({}) do |invoice_item, hash|
    if hash[invoice_item.item_id]
       hash[invoice_item.item_id] += invoice_item.subtotal
    else
      hash[invoice_item.item_id] = invoice_item.subtotal
    end
    end
  end

  def items_for_invoice_items
    successful_invoice_items.each_with_object({}) do |invoice_item, hash|
    if hash[invoice_item.item_id]
       hash[invoice_item.item_id] += invoice_item.quantity
    else
      hash[invoice_item.item_id] = invoice_item.quantity
    end  
    end
  end

  
end
