require 'csv'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transactions_repository'
require_relative '../lib/transactions'
require_relative '../lib/sales_engine'

class TransactionTest < MiniTest::Test
  def setup
    transaction_data = CSV.read'./data/transactions_test.csv', headers: true, header_converters: :symbol
    @transaction = Transaction.new
  end

end
