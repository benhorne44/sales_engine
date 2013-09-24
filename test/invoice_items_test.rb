require 'csv'
require 'minitest'
require 'minitest/autorun'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'

class InvoiceItemTest < MiniTest::Test
  def setup
    customer_data = CSV.read'./data/invoice_items_test.csv', headers: true, header_converters: :symbol
    @invoice_item = InvoiceItem.new
  end

end

class InvoiceItemRepositoryTest < MiniTest::Test
  def setup
    @invoice_item_data = CSV.read'./data/invoice_items_test.csv', headers: true, header_converters: :symbol
    @ii = InvoiceItemRepository.new
    @ii.load_file('./data/invoice_items_test.csv')
  end

  def test_it_loads_file
    response = @ii.load_file('./data/invoice_items_test.csv')
    assert_equal @invoice_item_data, response
  end

  def test_it_gives_random_invoice_item
    match = 0
    20.times  do
      response = @ii.random["invoice_item_id"]
      expected = @ii.random['invoice_item_id']
      if response == expected
        match += 1
      end
    end
    assert_operator match, :<, 20
  end

  def test_it_finds_all_by_item_id
    response = @ii.find_all_by_item_id('2055')
    assert_equal 2, response.count
  end

  def test_it_finds_one_by_item_id
    response = @ii.find_by_item_id('2055')
    assert_equal 1, response.count
  end

  def test_it_finds_by_invoice_item_id
    response = @ii.find_by_invoice_item_id('21687')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_quantity
    response = @ii.find_all_by_quantity('3')
    assert_equal 2, response.count
  end

  def test_it_finds_by_quantity
    response = @ii.find_by_quantity('3')
    assert_equal 1, response.count
  end

  def test_it_finds_by_unit_price
    response = @ii.find_by_unit_price('54368')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_unit_price
    response = @ii.find_all_by_unit_price('54368')
    assert_equal 2, response.count
  end
end
  
