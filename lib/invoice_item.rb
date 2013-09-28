class InvoiceItem
  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at, :engine

  def initialize(input, engine)
    @id = input[:id]
    @item_id = input[:item_id]
    @invoice_id = input[:invoice_id]
    @quantity = input[:quantity]
    @unit_price = input[:unit_price]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
    @engine = engine
  end

  def item_repo
    @item_repo ||= engine.item_repository
  end

  def item
    item_repo.find_by_item_id(item_id)
  end

  def invoice_repo
    @invoice_repo ||= engine.invoice_repository
  end

  def invoice
    invoice_repo.find_by_invoice_id(invoice_id)
  end

end
