class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :engine

  def initialize(input, engine)
    @id = input[:id].to_i
    @first_name = input[:first_name]
    @last_name = input[:last_name]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
    @engine = engine
  end

  def invoice_repo
    engine.invoice_repository
  end

  def invoices
    invoice_repo.find_all_by_customer_id(id)
  end

  def successful_invoices
    @successful_invoices ||= invoice_repo.find_all_by_customer_id(id)
  end

  def transactions
    invoices.collect { |invoice| transaction_repo.find_all_by_invoice_id(invoice.id) }
  end

  def transaction_repo
    engine.transaction_repository
  end

  def favorite_merchant
    engine.merchant_repository.find_by_id(favorite_merchant_id)
  end

  def favorite_merchant_id
    invoices_grouped_by_merchant.max_by { |id, invoices| invoices.count }[0]
  end

  def invoices_grouped_by_merchant
    successful_invoices.group_by {|inv| inv.merchant_id}
  end

end

