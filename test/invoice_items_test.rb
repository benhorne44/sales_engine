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

class InvoiceItemRepositoryTest < MiniTest::Test
 
  def repo
    @repo ||= load_data
  end

  def load_data
    ii = InvoiceItemRepository.new
    ii.load_file('./data/invoice_items_test.csv')
    return ii
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

  def test_it_finds_all_by_item_id
    response = repo.find_all_by_item_id('2055')
    assert_equal 2, response.count
    response.each { |invoice_item| assert_equal '2055', invoice_item.item_id }
  end

  def test_it_finds_one_by_item_id
    response = repo.find_by_item_id('2055')
    assert_equal '2055', response.item_id
  end

  def test_it_finds_by_invoice_item_id
    response = repo.find_by_invoice_item_id('21687')
    assert_equal '21687', response.id
  end

  def test_it_finds_all_by_quantity
    response = repo.find_all_by_quantity('3')
    assert_equal 2, response.count
    response.each { |invoice_item| assert_equal '3', invoice_item.quantity }
  end

  def test_it_finds_by_quantity
    response = repo.find_by_quantity('3')
    assert_equal '3', response.quantity
  end

  def test_it_finds_by_unit_price
    response = repo.find_by_unit_price('54368')
    assert_equal '54368', response.unit_price
  end

  def test_it_finds_all_by_unit_price
    response = repo.find_all_by_unit_price('54368')
    assert_equal 2, response.count
    response.each { |invoice_item| assert_equal '54368', invoice_item.unit_price }
  end

  def test_it_finds_by_invoice_item_created_at
    response = repo.find_by_invoice_item_created_at('2012-03-27 14:58:15 UTC')
    assert_equal '2012-03-27 14:58:15 UTC', response.created_at
  end

  def test_it_finds_all_by_invoice_item_created_at
    response = repo.find_all_by_invoice_item_created_at('2012-03-27 14:58:15 UTC')
    assert_equal 4, response.count
    response.each { |invoice_item| assert_equal '2012-03-27 14:58:15 UTC', invoice_item.created_at }
  end

  def test_it_finds_by_invoice_item_updated_at
    response = repo.find_by_invoice_item_updated_at('2012-03-27 14:58:15 UTC')
    assert_equal '2012-03-27 14:58:15 UTC', response.updated_at
  end

  def test_it_finds_all_by_invoice_item_updated_at
    response = repo.find_all_by_invoice_item_updated_at('2012-03-27 14:58:15 UTC')
    assert_equal 4, response.count
    response.each { |invoice_item| assert_equal '2012-03-27 14:58:15 UTC', invoice_item.updated_at }
  end

  def test_it_finds_all_invoice_items
    response = repo.all
    assert_equal 5, response.count
  end

end
  
