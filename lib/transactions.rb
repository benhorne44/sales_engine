class Transaction
  attr_reader :id, :credit_card_number, :credit_card_expiration_date, :result, :invoice_id, :created_at, :updated_at, :engine


  def initialize(input, engine)
    @id = input[:id].to_i
    @credit_card_number = input[:credit_card_number]
    @credit_card_expiration_date = input[:credit_card_expiration_date]
    @result = input[:result]
    @invoice_id = input[:invoice_id].to_i
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
    @engine = engine
  end

  def invoice_repo
    @invoice_repo ||= engine.invoice_repository
  end

  def invoice
    invoice_repo.find_by_id(invoice_id)
  end

  def successful?
    transaction.result == 'success'
  end



end
