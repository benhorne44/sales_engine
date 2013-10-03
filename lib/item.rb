class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at, :engine
  

  def initialize(input, engine)
    @id = input[:id].to_i
    @name = input[:name]
    @description = input[:description]
    @unit_price = input[:unit_price].to_i
    @merchant_id = input[:merchant_id].to_i
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
    @engine = engine
  end

  
  def merchant_repo
    @merchant_repo ||= engine.merchant_repository
  end

  def merchant
    merchant_repo.find_by_id(merchant_id)
  end

  def invoice_item_repo
    @invoice_item_repo ||= engine.invoice_item_repository
  end

  def invoice_items
    invoice_item_repo.find_all_by_item_id(id)
  end

  def successful_invoice_items
    invoice_items.select { |invoice_item| invoice_item.invoice.successful? }
  end

  def quantities_by_date
    successful_invoice_items.each_with_object({}) do |invoice_item, hash|
    if hash[invoice_item.invoice.created_at]
       hash[invoice_item.invoice.created_at] += invoice_item.quantity
    else
      hash[invoice_item.invoice.created_at] = invoice_item.quantity
    end
    end
  end

  def best_day
    hash = quantities_by_date.sort_by { |id, quantity| -quantity }
    return Date.parse(hash.first[0])
  end

end
