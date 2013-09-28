class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :engine

  def initialize(input, engine)
    @id = input[:id]
    @customer_id = input[:customer_id]
    @merchant_id = input[:merchant_id]
    @status = input[:status]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
    @engine = engine
  end

  def transactions_repo
    @transactions_repo ||= engine.transactions_repository
  end

  def transactions
    transactions_repo.find_all_by_invoice_id(id)
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
    customers_repo.find_by_customer_id(customer_id)
  end

  def merchant_repo
    @merchant_repo ||= engine.merchant_repository
  end

  def merchant
    merchant_repo.find_by_merchant_id(merchant_id)
  end

end
