class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :engine

  def initialize(input, engine)
    @id = input[:id]
    @first_name = input[:first_name]
    @last_name = input[:last_name]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
    @engine = engine
  end

  def invoices_repo
    @invoices_repo ||= engine.invoice_repository
  end

  def invoices
    invoices_repo.find_all_by_customer_id(id)
  end

end

