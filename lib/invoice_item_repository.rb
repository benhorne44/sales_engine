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
    invoice_items_by_invoice_id[id]
  end

  def find_by_invoice_id(id)
    invoice_items_by_invoice_id[id].first
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
    invoice_items.find{|i| i.unit_price == price_in_cents(price).to_i }
  end

  def price_in_cents(price)
    price_in_cents = price*100
  end

  def find_all_by_unit_price(price)
    invoice_items.find_all{|i| i.unit_price == price_in_cents(price).to_i }
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
    successful_invoice_items.each_with_object(Hash.new(0)) do |invoice_item, subtotal| 
      subtotal[invoice_item] += invoice_item.subtotal
    end
  end

  def items_for_invoice_items
    successful_invoice_items.each_with_object(Hash.new(0)) do |invoice_item, item_total| 
      item_total[invoice_item] += invoice_item.quantity
    end
  end

  def last_invoice_item_id
    invoice_items.max_by {|invoice_item| invoice_item.id}.id + 1
  end

  def create(invoice_data, new_invoice)
    q = []
    formatted_data_hashes = invoice_data[:items].each do |item|
      data_per_item = {
        created_id: last_invoice_item_id,
        item_id: item.id,
        invoice_id: invoice_data[:id],
        quantity: invoice_data[:items].select { |items| items.id == item.id }.count,
        unit_price: item.unit_price,
        created_at: Time.now,
        updated_at: Time.now
      }

      new_invoice_item = InvoiceItem.new(data_per_item, engine)
      unless exists?(new_invoice_item)
        add_new_invoice_to_all(new_invoice_item)
      end
    end
  end

  def add_new_invoice_to_all(new_invoice_item)
    engine.invoice_item_repository.all.push(new_invoice_item)
  end

  def exists?(new_invoice_item)
    engine.invoice_item_repository.find_by_id(new_invoice_item.id)
  end

  def invoice_items_by_invoice_id
    @invoice_items_by_invoice_id ||= invoice_items.group_by { |invoice_item| invoice_item.invoice_id}
  end

  def update_items_for_new_invoice(new_invoice, items)
    items.each {|item| invoice_items.items.push(item) }
  end

  
end
