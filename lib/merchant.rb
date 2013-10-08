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
    successful_invoices.collect { |inv| inv.invoice_items }.flatten
  end

  def total_items_sold
    successful_invoice_items.inject(0) {|total, invoice_item| total += invoice_item.quantity}
  end

  def pending_invoices
    invoices.reject { |invoice| invoice.successful?}
  end

  def customers_with_pending_invoices
    pending_invoices.collect { |inv| customer_repo.find_by_id(inv.customer_id) }
  end

  def subtotal
    @subtotal ||= successful_invoices.inject(0) { |subtotal, invoice| subtotal += invoice.total } 
  end

  def customer_repo
    @customer_repo ||= engine.customer_repository
  end

  def successful_invoices_for_given_date(date)
    successful_invoices.find_all{|invoice| Date.parse(invoice.created_at) == date}
  end

  def total_for_invoices(list_of_invoices)
    list_of_invoices.inject(0) { |total, invoice| total += invoice.total}
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
    invoices.collect { |invoice| customer_repo.find_by_id(invoice.customer_id) }
  end

  def invoices_by_customer_id
    successful_invoices.group_by {|inv| inv.customer_id}
  end

  def favorite_customer
    customer_repo.find_by_id(favorite_customer_id)
  end

  def favorite_customer_id
    invoices_by_customer_id.max_by {|id, invoices| invoices.count}[0]
  end


end
