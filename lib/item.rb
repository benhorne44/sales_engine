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

  def total_revenue
    successful_invoice_items.inject(0) { |sum, invoice_item| sum += invoice_item.subtotal }
  end

  def quantity_sold
    successful_invoice_items.inject(0) { |quantity, invoice_item| quantity += invoice_item.quantity }
  end

  def quantities_by_date
    successful_invoice_items.each_with_object(Hash.new(0)) do |invoice_item, hash|
       hash[invoice_item.invoice.created_at] += invoice_item.quantity
    end
  end

  def best_day
    Date.parse(sorted_quantities_by_date.first[0])
  end

  def sorted_quantities_by_date
    quantities_by_date.sort_by { |id, quantity| quantity }.reverse
  end

end
