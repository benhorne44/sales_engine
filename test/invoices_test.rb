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
