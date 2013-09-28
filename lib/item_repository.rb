require 'csv'

class ItemRepository

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end


  def load_file(filename='')
    if filename == ''
      filename = './data/items.csv'
    end
    @contents = CSV.read"#{filename}", headers: true, header_converters: :symbol
    return @contents
  end

  def items
    @items ||= load_items
  end

  def load_items
    load_file.collect { |row| Item.new(row, engine) }
  end

  def random
    items.sample
  end

  def find_by_item_name(name)
    items.find{|item| item.name == name }
  end

  def find_all_by_item_name(name)
    items.find_all{|item| item.name == name }
  end

  def find_by_item_id(id)
    items.find{|item| item.id == id }
  end

  def find_by_item_description(input)
    items.find{|item| item.description == input }
  end

  def find_all_by_item_description(input)
    items.find_all{|item| item.description == input }
  end

  def find_by_unit_price(price)
    items.find{|item| item.unit_price == price }
  end

  def find_all_by_unit_price(price)
    items.find_all{|item| item.unit_price == price }
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
end
