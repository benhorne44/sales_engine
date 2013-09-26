class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

  def initialize(input)
    @id = input[:id]
    @customer_id = input[:customer_id]
    @merchant_id = input[:merchant_id]
    @status = input[:status]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
  end

  def id
    @id
  end

  def customer_id
    @customer_id
  end

  def merchant_id
    @merchant_id
  end

  def status
    @status
  end

  def created_at
    @created_at
  end

  def updated_at
    @updated_at
  end


end
