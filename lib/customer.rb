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

  def invoices_repo
    @invoices_repo ||= engine.invoice_repository
  end

  def merchant_repo
    @merchant_repo ||= engine.merchant_repository
  end

  def invoices
    invoices_repo.find_all_by_customer_id(id)
  end

  def transactions_repo
    @transactions_repo ||= engine.transaction_repository
  end

  def transactions
    invoices.collect { |invoice| transactions_repo.find_all_by_invoice_id(invoice.id) }
  end

  def successful?
    transactions.any? { |transaction| transaction.result == 'success' }
  end

  def successful_transactions
    transactions.select { |transaction| transaction.successful? }
  end

  def favorite_merchant
    invoices_grouped_by_merchant = successful_invoices.group_by {|inv| inv.merchant_id}
    fav_merchant_id = nil
    fav_merchant_inv_count = 0
    invoices_grouped_by_merchant.each do |merchant_id, merchant_invoices|
      merchant_invoices_count = merchant_invoices.count
      if merchant_invoices_count > fav_merchant_inv_count
        fav_merchant_id = merchant_id
        fav_merchant_inv_count = merchant_invoices_count
      end
    end
    merchant_repo.find_by_id(fav_merchant_id)
  end

  def successful_invoices
    @successful_invoices ||= invoices.select { |invoice| invoice.successful? }
  end

end

