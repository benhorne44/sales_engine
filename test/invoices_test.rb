require 'csv'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

class InvoiceTest < MiniTest::Test
  def setup
    invoice_data = CSV.read'./data/invoices_test.csv', headers: true, header_converters: :symbol
    @invoice = Invoice.new
  end
end

class InvoiceRepositoryTest < MiniTest::Test
  def setup
    @invoice_data = CSV.read'./data/invoices_test.csv', headers: true, header_converters: :symbol
    @i = InvoiceRepository.new('./data/invoices_test.csv')
  end

  def test_it_gives_random_invoice_item
    match = 0
    20.times  do
      response = @i.random["invoice_id"]
      expected = @i.random['invoice_id']
      if response == expected
        match += 1
      end
    end
    assert_operator match, :<, 20
  end

  def test_it_finds_by_invoice_id
    response = @i.find_by_invoice_id('4842')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_customer_id
    response = @i.find_all_by_customer_id('1000')
    assert_equal 4, response.count
  end

  def test_it_finds_one_by_customer_id
    response = @i.find_by_customer_id('1000')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_merchant_id
    response = @i.find_all_by_merchant_id('53')
    assert_equal 2, response.count
  end
 
  def test_it_finds_one_by_merchant_id
    response = @i.find_by_merchant_id('53')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_invoice_status
    response = @i.find_all_by_invoice_status('shipped')
    assert_equal 4, response.count
  end

  def test_it_finds_one_by_invoice_status
    response = @i.find_by_invoice_status('shipped')
    assert_equal 1, response.count
  end

  def test_it_finds_by_invoice_created_at
    response = @i.find_by_invoice_created_at('2012-03-27 00:58:15 UTC')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_invoice_created_at
    response = @i.find_all_by_invoice_created_at('2012-03-27 00:58:15 UTC')
    assert_equal 2, response.count
  end

  def test_it_finds_by_invoice_updated_at
    response = @i.find_by_invoice_updated_at('2012-03-27 00:58:15 UTC')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_invoice_updated_at
    response = @i.find_all_by_invoice_updated_at('2012-03-27 00:58:15 UTC')
    assert_equal 2, response.count
  end

  def test_it_finds_all
    response = @i.all
    assert_equal 4, response.count
  end
end
  
