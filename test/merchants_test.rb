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

class MerchantTest < MiniTest::Test

  def load_data
    mr = MerchantRepository.new
    contents = mr.load_file('./data/merchants_test.csv')
    return contents
  end

  def create_specific_merchant_with_id(id)
    merchants = load_data.collect {|row| Merchant.new(row) }
    merchants.each do |merchant|
      if merchant.id == id
        @merchant = merchant
      end
    end
    return @merchant
  end

  def test_it_finds_all_items_associated_with_specific_merchant
    create_specific_merchant_with_id('100')
    response = @merchant.items
    assert_equal 4, response.count
    response.each { |item| assert_equal '100', item.merchant_id }
  end

  def test_it_finds_all_invoices_associated_with_specific_merchant
    create_specific_merchant_with_id('8')
    response = @merchant.invoices
    assert_equal 1, response.count
    response.each { |invoice| assert_equal '8', invoice.merchant_id }
  end

end
