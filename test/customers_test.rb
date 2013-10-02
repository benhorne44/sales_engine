require 'csv'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

class CustomerTest < MiniTest::Test
  def setup
    load_csv_files
  end


  def engine
    engine ||= SalesEngine.new
  end

  def load_csv_files
    engine.customer_repository.load_file('./data/customers_test.csv')
    engine.invoice_repository.load_file('./data/invoices_test.csv')
  end



end
