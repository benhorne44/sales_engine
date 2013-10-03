class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :engine

  def initialize(input, engine)
    @id = input[:id].to_i
    @customer_id = input[:customer_id].to_i
    @merchant_id = input[:merchant_id].to_i
    @status = input[:status]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
    @engine = engine
  end

  def transactions_repo
    @transactions_repo ||= engine.transaction_repository
  end

  def transactions
    transactions_repo.find_all_by_invoice_id(id)
  end

  def successful?
    transactions.any? { |transaction| transaction.result == 'success' }
  end

  def total
    @total ||= invoice_items.collect do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end.reduce(0, :+)
  end

  def invoice_item_repo
    @invoice_item_repo ||= engine.invoice_item_repository
  end

  def invoice_items
    invoice_item_repo.find_all_by_invoice_id(id)
  end

  def items
    invoice_items.map{ |i| i.item }
  end

  def customers_repo
    @customers_repo ||= engine.customer_repository
  end

  def customer
    customers_repo.find_by_id(customer_id)
  end

  def merchant_repo
    @merchant_repo ||= engine.merchant_repository
  end

  def merchant
    merchant_repo.find_by_id(merchant_id)
  end

end
