require 'csv'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class MerchantTest < MiniTest::Test
  def setup
    merchant_data = CSV.read'./data/merchants_test.csv', headers: true, header_converters: :symbol
    @merchant = Merchant.new
  end

end

class MerchantRepositoryTest < MiniTest::Test
  def setup
    @merchant_data = CSV.read'./data/merchants_test.csv', headers: true, header_converters: :symbol
    @mr = MerchantRepository.new
    @mr.load_file('./data/merchants_test.csv')
  end

  def test_it_gives_random_merchant
    match = 0
    20.times  do
      response = @mr.random["merchant_id"]
      expected = @mr.random['merchant_id']
      if response == expected
        match += 1
      end
    end
    assert_operator match, :<, 20
  end

  def test_it_finds_all_by_merchant_name
    response = @mr.find_all_by_merchant_name('Schroeder-Jerde')
    assert_equal 2, response.count
  end

  def test_it_finds_one_by_merchant_name
    response = @mr.find_by_merchant_name('Schroeder-Jerde')
    assert_equal 1, response.count
  end

  def test_it_finds_by_merchant_id
    response = @mr.find_by_merchant_id('3')
    assert_equal 1, response.count
  end

  def test_it_finds_by_merchant_created_at
    response = @mr.find_by_merchant_created_at('2012-03-27 14:53:59 UTC')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_merchant_created_at
    response = @mr.find_all_by_merchant_created_at('2012-03-27 14:53:59 UTC')
    assert_equal 4, response.count
  end

  def test_it_finds_by_merchant_updated_at
    response = @mr.find_by_merchant_updated_at('2012-03-27 14:53:59 UTC')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_merchant_updated_at
    response = @mr.find_all_by_merchant_updated_at('2012-03-27 14:53:59 UTC')
    assert_equal 4, response.count
  end

  def test_it_finds_by_all
    response = @mr.all
    assert_equal 4, response.count    
  end

  def test_it_finds_invoices_for_merchant
    # skip
    # find all invoices for merchant 3 using "merchant_id" == 3
    # invoice["merchant_id"] == 3
      # queue.push results
    # @ir = InvoiceRepository.new('./data/invoices_test.csv')
    # @ir.find_by_merchant('3')
    #   @ir.find_by('merchant_id', '3')
  end
end
  
