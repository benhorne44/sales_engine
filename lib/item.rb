class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at
  

  def initialize(input)
    @id = input[:id]
    @name = input[:name]
    @description = input[:description]
    @unit_price = input[:unit_price]
    @merchant_id = input[:merchant_id]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
  end

  def id
    @id
  end

  def name
    @name
  end

  def description
    @description
  end

  def unit_price
    @unit_price
  end

  def merchant_id
    @merchant_id
  end

  def created_at
    @created_at
  end

  def updated_at
    @updated_at
  end

  def merchant_repo
    @merchant_repo ||= MerchantRepository.new
  end

  def invoice_item_repo
    @invoice_item_repo ||= InvoiceItemRepository.new
  end

  def merchant
    merchant_repo.find_by_merchant_id(@merchant_id)
  end

  def invoice_items
    invoice_item_repo.find_all_by_item_id(@id)
  end


end
