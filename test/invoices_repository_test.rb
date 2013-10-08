require 'csv'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'




class InvoiceRepositoryTest < MiniTest::Test
  
  def setup
    @engine ||= SalesEngine.new
    @engine.invoice_repository.load_file('./data/invoices_test.csv')
    @engine.invoice_item_repository.load_file('./data/invoice_items_test.csv')
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
    response = repo.find_by_id(4842)
    assert_equal 4842, response.id
  end

  def test_it_finds_all_by_customer_id
    response = repo.find_all_by_customer_id(1000)
    assert_equal 4, response.count
    response.each { |invoice| assert_equal 1000, invoice.customer_id }
  end

  def test_it_finds_one_by_customer_id
    response = repo.find_by_customer_id(1000)
    assert_equal 1000, response.customer_id
  end

  def test_it_finds_all_by_merchant_id
    response = repo.find_all_by_merchant_id(53)
    assert_equal 2, response.count
    response.each { |invoice| assert_equal 53, invoice.merchant_id }
  end
 
  def test_it_finds_one_by_merchant_id
    response = repo.find_by_merchant_id(53)
    assert_equal 53, response.merchant_id
  end

  def test_it_finds_all_by_invoice_status
    response = repo.find_all_by_status('shipped')
    assert_equal 4, response.count
    response.each { |invoice| assert_equal 'shipped', invoice.status }
  end

  def test_it_finds_one_by_invoice_status
    response = repo.find_by_status('shipped')
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

  def test_it_finds_last_invoice_id
    result = @engine.invoice_repository.last_invoice_id
    assert_equal 4845, result
  end



  # def test_it_creates_an_invoice
  #   @engine.customer_repository.load_file('./data/customers.csv')
  #   @engine.merchant_repository.load_file('./data/merchants.csv')
  #   @engine.item_repository.load_file('./data/items.csv')
  #   customer = @engine.customer_repository.find_by_id(7)
  #   merchant = @engine.merchant_repository.find_by_id(22)
  #   items = (1..3).map { @engine.item_repository.random  }
  #   results = @engine.invoice_repository.create(customer: customer, merchant: merchant, items: items)

  #   assert_equal Invoice, results.class
  # end

  def test_it_creates_an_invoice
    customer = Customer.new({id: 7 }, @engine)
    merchant = Merchant.new({id: 22}, @engine) 
    items = [Item.new({id: 1, unit_price: 3333}, @engine), Item.new({id: 2, unit_price: 3333}, @engine), Item.new({id: 1, unit_price: 3333}, @engine)]
    hash = {customer: customer, merchant: merchant, items: items} 
    result = @engine.invoice_repository.create(hash)
    assert_equal Invoice, result.class
    assert_equal 7, result.customer_id
    assert_equal 22, result.merchant_id

  end

  # def test_it_creates_an_invoice_item
  #   customer = Customer.new({id: 7 }, @engine)
  #   merchant = Merchant.new({id: 22}, @engine) 
  #   items = [Item.new({id: 1, unit_price: 3333}, @engine), Item.new({id: 2, unit_price: 3333}, @engine), Item.new({id: 1, unit_price: 3333}, @engine)]
  #   invoice = Invoice.new({id: 1}, @engine)
  #   hash = {customer: customer, merchant: merchant, items: items} 
  #   # result_hash = @engine.invoice_repository.format_invoice_item_data(hash, invoice)

  #   # final_hash = {id: , item_id:, invoice_id:, quantity:, unit_price:, created_at:, updated_at: }
  #   assert_equal 2, r
  # end


end
  
