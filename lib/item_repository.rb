require 'csv'
class ItemRepository

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def load_file(filename)
    @contents = CSV.read"#{filename}", headers: true, header_converters: :symbol
  end

  def items
    @items ||= load_items
  end

  def load_items
    @contents.collect { |row| Item.new(row, engine) }
  end

  def random
    items.sample
  end

  def find_by_name(name)
    items.find{|item| item.name == name }
  end

  def find_all_by_name(name)
    items.find_all{|item| item.name == name }
  end

  def find_by_id(id)
    items.find{|item| item.id == id }
  end

  def find_by_item_description(input)
    items.find{|item| item.description == input }
  end

  def find_all_by_item_description(input)
    items.find_all{|item| item.description == input }
  end

  def price_in_cents(price)
    price*100.to_i
  end

  def find_by_unit_price(price)
    items.find{|item| item.unit_price == price_in_cents(price)}
  end

  def find_all_by_unit_price(price)
    items.find_all{|item| item.unit_price == price_in_cents(price)}
  end

  def find_by_merchant_id(id)
    items.find{|item| item.merchant_id == id }
  end

  def find_all_by_merchant_id(id)
    items.find_all{|item| item.merchant_id == id }
  end

  def find_by_item_created_at(date)
    items.find{|item| item.created_at == date }
  end

  def find_all_by_item_created_at(date)
    items.find_all{|item| item.created_at == date }
  end

  def find_by_item_updated_at(date)
    items.find{|item| item.updated_at == date }
  end

  def find_all_by_item_updated_at(date)
    items.find_all{|item| item.updated_at == date }
  end

  def all
    items
  end

  def most_revenue(number)
    items_sorted_by_revenue[0, number]
  end

  def items_sorted_by_revenue
    items.sort_by { |item| item.total_revenue}.reverse
  end

  def most_items(number)
    items_sorted_by_quantity_sold[0, number]
  end

  def items_sorted_by_quantity_sold
    items.sort_by {|item| item.quantity_sold}.reverse
  end

end
