require 'csv'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class MerchantTest < MiniTest::Test

 def setup
  @engine ||= SalesEngine.new
  @engine.merchant_repository.load_file('./data/merchants_test.csv')
  @merchant = @engine.merchant_repository.find_by_id(1)
 end

 def test_it_finds_favorite_customer
  # result = @merchant.favorite_customer

  assert_equal '2', @merchant
   
 end
end
