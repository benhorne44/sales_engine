class Merchant
  attr_reader :id, :name, :created_at, :updated_at, :engine
 
  def initialize(input, engine)
    @id = input[:id].to_i
    @name = input[:name]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
    @engine = engine
  end

  def item_repo
    @item_repo ||= engine.item_repository
  end

  def items
    item_repo.find_all_by_merchant_id(id)
  end

  def invoice_repo
    @invoice_repo ||= engine.invoice_repository
  end

  def invoices
    @invoices ||= invoice_repo.find_all_by_merchant_id(id)
  end

  def successful_invoices
    @successful_invoices ||= invoices.select { |invoice| invoice.successful? }
  end

  def successful_invoice_items
    successful_invoices.collect do |invoice| 
      invoice.invoice_items
    end
  end

  def total_items_sold
    total = 0
    successful_invoice_items.flatten.each do |invoice_item|
      total += invoice_item.quantity
    end
    return total
  end


  def pending_invoices
    invoices.reject { |invoice| invoice.successful?}
  end

  def customers_with_pending_invoices
    pending_invoices.collect do |invoice|
      customer_repo.find_by_id(invoice.customer_id)
    end
  end

  def subtotal
    @subtotal ||= successful_invoices.collect do |invoice|
      invoice.total
    end.reduce(0, :+)
  end

  def customer_repo
    @customer_repo ||= engine.customer_repository
  end

  def successful_invoices_for_given_date(date)
    successful_invoices.find_all{|invoice| Date.parse(invoice.created_at) == date}
  end

  def total_for_invoices(list_of_invoices)
    invoice_totals = list_of_invoices.collect do |invoice|
      invoice.total
    end
    invoice_totals.reduce(0,:+)
  end

  def subtotal_for(date)
    total_for_invoices(successful_invoices_for_given_date(date))
  end

  def revenue(date = nil)
    if date.nil?
      BigDecimal.new(subtotal)/100
    else
      BigDecimal.new(subtotal_for(date))/100
    end
  end

  def customers
    invoices.collect do |invoice|
      customer_repo.find_by_id(invoice.customer_id)
    end
  end

  def favorite_customer
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
