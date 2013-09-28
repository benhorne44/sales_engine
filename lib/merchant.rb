class Merchant
  attr_reader :id, :name, :created_at, :updated_at, :engine
 
  def initialize(input, engine)
    @id = input[:id]
    @name = input[:name]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
    @engine = engine
  end

  def item_repo
    @item_repo ||= engine.item_repository
  end

  def items
    item_repo.find_all_by_merchant_id(id)
  end

  def invoice_repo
    @invoice_repo ||= engine.invoice_repository
  end

  def invoices
    invoice_repo.find_all_by_merchant_id(id)
  end


end
