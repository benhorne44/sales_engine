require 'csv'
require 'minitest'
require 'minitest/autorun'
require_relative '../lib/transactions_repository'
require_relative '../lib/transactions'

class TransactionTest < MiniTest::Test
  def setup
    transaction_data = CSV.read'./data/transactions_test.csv', headers: true, header_converters: :symbol
    @transaction = Transaction.new
  end

end

class TransactionRepositoryTest < MiniTest::Test
  def setup
    @transaction_data = CSV.read'./data/transactions_test.csv', headers: true, header_converters: :symbol
    @t = TransactionRepository.new
    @t.load_file('./data/transactions_test.csv')
  end

  def test_it_gives_random_transaction
    match = 0
    20.times  do
      response = @t.random["transaction_id"]
      expected = @t.random['transaction_id']
      if response == expected
        match += 1
      end
    end
    assert_operator match, :<, 20
  end

  def test_it_finds_by_transaction_id
    response = @t.find_by_transaction_id('5593')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_invoice_id
    response = @t.find_all_by_invoice_id('4842')
    assert_equal 3, response.count
  end

  def test_it_finds_one_by_invoice_id
    response = @t.find_by_invoice_id('4842')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_credit_card_number
    response = @t.find_all_by_credit_card_number('4680790942233742')
    assert_equal 2, response.count
  end

  def test_it_finds_one_by_credit_card_number
    response = @t.find_by_credit_card_number('4680790942233742')
    assert_equal 1, response.count
  end

  #This is currently empty!!

  # def test_it_finds_all_by_credit_card_expiration_date
  #   response = @t.find_all_by_credit_card_expiration_date('92637')
  #   assert_equal 2, response.count
  # end

  # def test_it_finds_one_by_credit_card_expiration_date
  #   response = @t.find_by_credit_card_expiration_date('92637')
  #   assert_equal 1, response.count
  # end

  def test_it_finds_all_by_transaction_result
    response = @t.find_all_by_transaction_result('failed')
    assert_equal 2, response.count
  end

  def test_it_finds_one_by_transaction_result
    response = @t.find_by_transaction_result('failed')
    assert_equal 1, response.count
  end

  def test_it_finds_by_transaction_created_at
    response = @t.find_by_transaction_created_at('2012-03-27 14:58:15 UTC')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_transaction_created_at
    response = @t.find_all_by_transaction_created_at('2012-03-27 14:58:15 UTC')
    assert_equal 4, response.count
  end

  def test_it_finds_by_transaction_updated_at
    response = @t.find_by_transaction_updated_at('2012-03-27 14:58:15 UTC')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_transaction_updated_at
    response = @t.find_all_by_transaction_updated_at('2012-03-27 14:58:15 UTC')
    assert_equal 4, response.count
  end

  def test_it_finds_by_all
    response = @t.all
    assert_equal 4, response.count    
  end
end
