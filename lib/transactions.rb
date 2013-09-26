class Transaction
  attr_reader :id, :credit_card_number, :credit_card_expiration_date, :result, :invoice_id, :created_at, :updated_at


  def initialize(input)
    @id = input[:id]
    @credit_card_number = input[:credit_card_number]
    @credit_card_expiration_date = input[:credit_card_expiration_date]
    @result = input[:result]
    @invoice_id = input[:invoice_id]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
  end

  def id
    @id
  end

  def credit_card_number
    @credit_card_number
  end

  def credit_card_expiration_date
    @credit_card_expiration_date
  end

  def result
    @result
  end

  def invoice_id
    @invoice_id
  end

  def created_at
    @created_at
  end

  def updated_at
    @updated_at
  end

end
