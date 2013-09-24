require 'csv'
require 'minitest'
require 'minitest/autorun'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

class InvoiceTest < MiniTest::Test
  def setup
    invoice_data = CSV.read'../data/invoices_test.csv', headers: true, header_converters: :symbol
    @invoice = Invoice.new
  end

end

class InvoiceRepositoryTest < MiniTest::Test
  def setup
    @invoice_data = CSV.read'../data/invoices_test.csv', headers: true, header_converters: :symbol
    @i = InvoiceRepository.new
  end

  def test_it_loads_file
    response = @i.load_file('../data/invoices_test.csv')
    assert_equal @invoice_data, response
  end

  def test_it_formats_invoice_item_data
    @i.load_file('../data/invoices_test.csv')
    response = @i.format_invoice_data_into_hash
    @expected = {"invoice_id"=>"4841", "customer_id"=>"1000", "merchant_id"=>"8", "invoice_status"=>"shipped", "invoice_created_at"=>"2012-03-26 04:58:15 UTC", "invoice_updated_at"=>"2012-03-26 04:58:15 UTC"}, {"invoice_id"=>"4842", "customer_id"=>"1000", "merchant_id"=>"53", "invoice_status"=>"shipped", "invoice_created_at"=>"2012-03-27 00:58:15 UTC", "invoice_updated_at"=>"2012-03-27 00:58:15 UTC"}, {"invoice_id"=>"4843", "customer_id"=>"1000", "merchant_id"=>"86", "invoice_status"=>"shipped", "invoice_created_at"=>"2012-03-23 02:58:15 UTC", "invoice_updated_at"=>"2012-03-23 02:58:15 UTC"}
    assert_equal @expected, response
  end

  def test_it_gives_random_invoice_item
    @i.load_file('../data/invoices_test.csv')
    response = @i.random["invoice_id"]
    expected = @i.random['invoice_id']
 
    refute_equal response, expected
    # assert_operator match, :<, 20
  end

  # def test_it_gives_random_customer
  #   assert
  # end

end
  
