require 'csv'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transactions_repository'
require_relative '../lib/transactions'
require_relative '../lib/sales_engine'

class TransactionRepositoryTest < MiniTest::Test
  
  def setup
    @engine ||= SalesEngine.new
    @engine.transaction_repository.load_file('./data/transactions_test.csv')
  end

  def repo
    @engine.transaction_repository 
  end

  def test_it_gives_random_transaction
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

  def test_it_finds_by_id
    response = repo.find_by_id(5593)
    assert_equal 5593, response.id
  end

  def test_it_finds_all_by_invoice_id
    response = repo.find_all_by_invoice_id(4842)
    assert_equal 3, response.count
    response.each { |transaction| assert_equal 4842, transaction.invoice_id }
  end

  def test_it_finds_one_by_invoice_id
    response = repo.find_by_invoice_id(4842)
    assert_equal 4842, response.invoice_id
  end

  def test_it_finds_all_by_credit_card_number
    response = repo.find_all_by_credit_card_number('4680790942233742')
    assert_equal 2, response.count
    response.each { |transaction| assert_equal '4680790942233742', transaction.credit_card_number }
  end

  def test_it_finds_one_by_credit_card_number
    response = repo.find_by_credit_card_number('4680790942233742')
    assert_equal '4680790942233742', response.credit_card_number
  end

  #This is currently empty!!

  # def test_it_finds_all_by_credit_card_expiration_date
  #   response = repo.find_all_by_credit_card_expiration_date('92637')
  #   assert_equal 2, response.count
  # end

  # def test_it_finds_one_by_credit_card_expiration_date
  #   response = repo.find_by_credit_card_expiration_date('92637')
  #   assert_equal 1, response.count
  # end

  def test_it_finds_all_by_transaction_result
    response = repo.find_all_by_result('failed')
    assert_equal 2, response.count
    response.each { |transaction| assert_equal 'failed', transaction.result }
  end

  def test_it_finds_one_by_transaction_result
    response = repo.find_by_result('failed')
    assert_equal 'failed', response.result
  end

  def test_it_finds_by_transaction_created_at
    response = repo.find_by_created_at('2012-03-27 14:58:15 UTC')
    assert_equal '2012-03-27 14:58:15 UTC', response.created_at
  end

  def test_it_finds_all_by_transaction_created_at
    response = repo.find_all_by_created_at('2012-03-27 14:58:15 UTC')
    assert_equal 4, response.count
    response.each { |transaction| assert_equal '2012-03-27 14:58:15 UTC', transaction.created_at }
  end

  def test_it_finds_by_transaction_updated_at
    response = repo.find_by_updated_at('2012-03-27 14:58:15 UTC')
    assert_equal '2012-03-27 14:58:15 UTC', response.updated_at
  end

  def test_it_finds_all_by_transaction_updated_at
    response = repo.find_all_by_updated_at('2012-03-27 14:58:15 UTC')
    assert_equal 4, response.count
    response.each { |transaction| assert_equal '2012-03-27 14:58:15 UTC', transaction.updated_at }
  end

  def test_it_finds_by_all
    response = repo.all
    assert_equal 4, response.count    
  end

end
