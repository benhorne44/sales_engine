require 'csv'
require_relative 'customer'
require_relative 'customer_repository'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'item'
require_relative 'item_repository'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'transactions'
require_relative 'transactions_repository'

class SalesEngine

  attr_accessor :merchant_repository,
                :item_repository,
                :invoice_repository,
                :invoice_item_repository,
                :customer_repository,
                :transaction_repository

  def initialize(dir = nil)
    @merchant_repository     = MerchantRepository.new(self)
    @item_repository         = ItemRepository.new(self)
    @invoice_repository      = InvoiceRepository.new(self)
    @invoice_item_repository = InvoiceItemRepository.new(self)
    @customer_repository     = CustomerRepository.new(self)
    @transaction_repository  = TransactionRepository.new(self)
    startup
  end

  def startup
    merchant_repository.load_file('./data/merchants.csv')
    item_repository.load_file('./data/items.csv')
    invoice_repository.load_file('./data/invoices.csv')
    customer_repository.load_file('./data/customers.csv')
    transaction_repository.load_file('./data/transactions.csv')
    invoice_item_repository.load_file('./data/invoice_items.csv')
  end

end
