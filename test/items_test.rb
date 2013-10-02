# require 'csv'
# require 'minitest'
# require 'minitest/autorun'
# require 'minitest/pride'
# require_relative '../lib/item_repository'
# require_relative '../lib/item'
# require_relative '../lib/merchant_repository'
# require_relative '../lib/merchant'
# require_relative '../lib/invoice_repository'
# require_relative '../lib/invoice'
# require_relative '../lib/sales_engine'

# class ItemTest < MiniTest::Test

#   def load_data
#     i = ItemRepository.new
#     contents = i.load_file('./data/items_test.csv')
#     return contents
#   end

#   def create_specific_item_with_id(id)
#     items = load_data.collect {|row| Item.new(row) }
#     items.each do |item|
#       if item.id == id
#         @item = item
#       end
#     end
#     return @item
#   end

#   def test_it_finds_an_invoice_item_associated_with_a_specific_item
#     create_specific_item_with_id('2484')
#     response = @item.invoice_items
#     assert_equal 1, response.count
#     response.each do |invoice_item| 
#       assert_equal '2484', invoice_item.item_id
#       assert_equal InvoiceItem, invoice_item.class
#     end
#   end

#   def test_it_finds_a_merchant_associated_with_a_specific_item
#     create_specific_item_with_id('2484')
#     response = @item.merchant
#     assert_equal Merchant, response.class
#     assert_equal '100', response.id
#   end
# end
