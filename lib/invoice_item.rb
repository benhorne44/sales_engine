class InvoiceItem
  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

  def initialize(input)
    @id = input[:id]
    @item_id = input[:item_id]
    @invoice_id = input[:invoice_id]
    @quantity = input[:quantity]
    @unit_price = input[:unit_price]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
  end

  def id
    @id
  end

  def item_id
    @item_id
  end

  def invoice_id
    @invoice_id
  end

  def quantity
    @quantity
  end

  def unit_price
    @unit_price
  end

  def created_at
    @created_at
  end

  def updated_at
    @updated_at
  end

end
