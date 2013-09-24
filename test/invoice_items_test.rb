require 'csv'
require 'minitest'
require 'minitest/autorun'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'

class InvoiceItemTest < MiniTest::Test
  def setup
    customer_data = CSV.read'../data/invoice_items_test.csv', headers: true, header_converters: :symbol
    @invoice_item = InvoiceItem.new
  end

end

class InvoiceItemRepositoryTest < MiniTest::Test
  def setup
    @invoice_item_data = CSV.read'../data/invoice_items_test.csv', headers: true, header_converters: :symbol
    @ii = InvoiceItemRepository.new
  end

  def test_it_loads_file
    response = @ii.load_file('../data/invoice_items_test.csv')
    assert_equal @invoice_item_data, response
  end

  def test_it_formats_invoice_item_data
    @ii.load_file('../data/invoice_items_test.csv')
    response = @ii.format_invoice_item_data_into_hash
    @expected = {"invoice_item_id"=>"21685", "item_id"=>"2055", "invoice_id"=>"4843", "item_quantity"=>"3", "unit_price"=>"54368", "created_at"=>"2012-03-27 14:58:15 UTC", "updated_at"=>"2012-03-27 14:58:15 UTC"}, {"invoice_item_id"=>"21686", "item_id"=>"2069", "invoice_id"=>"4843", "item_quantity"=>"5", "unit_price"=>"22220", "created_at"=>"2012-03-27 14:58:15 UTC", "updated_at"=>"2012-03-27 14:58:15 UTC"}, {"invoice_item_id"=>"21687", "item_id"=>"2054", "invoice_id"=>"4843", "item_quantity"=>"5", "unit_price"=>"54766", "created_at"=>"2012-03-27 14:58:15 UTC", "updated_at"=>"2012-03-27 14:58:15 UTC"}
    assert_equal @expected, response
  end

  def test_it_gives_random_invoice_item
    @ii.load_file('../data/invoice_items_test.csv')
    response = @ii.random["invoice_item_id"]
    expected = @ii.random['invoice_item_id']
 
    refute_equal response, expected
    # assert_operator match, :<, 20
  end

  # def test_it_gives_random_customer
  #   assert
  # end

end
  
