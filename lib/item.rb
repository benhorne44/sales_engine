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

  def best_day
    invoices_grouped_by_customer = successful_invoices.group_by {|inv| inv.customer_id}
    fav_customer_id = nil
    favorite_customer_inv_count = 0
    invoices_grouped_by_customer.each do |customer_id, customer_invoices|
      customer_invoices_count = customer_invoices.count
      if customer_invoices_count > favorite_customer_inv_count
        fav_customer_id = customer_id
        favorite_customer_inv_count = customer_invoices_count
      end
    end
    customer_repo.find_by_id(fav_customer_id)
  end

end
