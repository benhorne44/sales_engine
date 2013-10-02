require 'csv'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'

class InvoiceItemTest < MiniTest::Test
  def setup
    customer_data = CSV.read'./data/invoice_items_test.csv', headers: true, header_converters: :symbol
    @invoice_item = InvoiceItem.new
  end

end
