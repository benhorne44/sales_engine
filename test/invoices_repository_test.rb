require 'csv'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'



class InvoiceRepositoryTest < MiniTest::Test
  
  def setup
    @engine ||= SalesEngine.new
    @engine.invoice_repository.load_file('./data/invoices_test.csv')
  end

  def repo
    @engine.invoice_repository 
  end
  
  def test_it_gives_random_invoice_item
    match = 0
    20.times  do
      response = repo.random
      expected = repo.random
      if response == expected
        match += 1
      end
    end
    assert_operator match, :<, 20
  end

  def test_it_finds_by_invoice_id
    response = repo.find_by_invoice_id('4842')
    assert_equal '4842', response.id
  end

  def test_it_finds_all_by_customer_id
    response = repo.find_all_by_customer_id('1000')
    assert_equal 4, response.count
    response.each { |invoice| assert_equal '1000', invoice.customer_id }
  end

  def test_it_finds_one_by_customer_id
    response = repo.find_by_customer_id('1000')
    assert_equal '1000', response.customer_id
  end

  def test_it_finds_all_by_merchant_id
    response = repo.find_all_by_merchant_id('53')
    assert_equal 2, response.count
    response.each { |invoice| assert_equal '53', invoice.merchant_id }
  end
 
  def test_it_finds_one_by_merchant_id
    response = repo.find_by_merchant_id('53')
    assert_equal '53', response.merchant_id
  end

  def test_it_finds_all_by_invoice_status
    response = repo.find_all_by_invoice_status('shipped')
    assert_equal 4, response.count
    response.each { |invoice| assert_equal 'shipped', invoice.status }
  end

  def test_it_finds_one_by_invoice_status
    response = repo.find_by_invoice_status('shipped')
    assert_equal 'shipped', response.status
  end

  def test_it_finds_by_invoice_created_at
    response = repo.find_by_invoice_created_at('2012-03-27 00:58:15 UTC')
    assert_equal '2012-03-27 00:58:15 UTC', response.created_at
  end

  def test_it_finds_all_by_invoice_created_at
    response = repo.find_all_by_invoice_created_at('2012-03-27 00:58:15 UTC')
    assert_equal 2, response.count
    response.each { |invoice| assert_equal '2012-03-27 00:58:15 UTC', invoice.created_at }
  end

  def test_it_finds_by_invoice_updated_at
    response = repo.find_by_invoice_updated_at('2012-03-27 00:58:15 UTC')
    assert_equal '2012-03-27 00:58:15 UTC', response.updated_at
  end

  def test_it_finds_all_by_invoice_updated_at
    response = repo.find_all_by_invoice_updated_at('2012-03-27 00:58:15 UTC')
    assert_equal 2, response.count
    response.each { |invoice| assert_equal '2012-03-27 00:58:15 UTC', invoice.updated_at }
  end

  def test_it_finds_all
    response = repo.all
    assert_equal 4, response.count
  end
end
  
