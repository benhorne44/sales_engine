require 'csv'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'


class MerchantRepositoryTest < MiniTest::Test
  def setup
    @engine ||= SalesEngine.new
    @engine.merchant_repository.load_file('./data/merchants_test.csv')
  end

  def merchant_repository
    @engine.merchant_repository
  end

  def test_it_gives_random_merchant
    match = 0
    20.times  do
      response = merchant_repository.random
      expected = merchant_repository.random
      if response == expected
        match += 1
      end
    end
    assert_operator match, :<, 20
  end

  def test_it_finds_all_by_merchant_name
    response = merchant_repository.find_all_by_merchant_name('Schroeder-Jerde')

    assert_equal 2, response.count
    response.each { |merchant| assert_equal 'Schroeder-Jerde', merchant.name }
  end

  def test_it_finds_one_by_merchant_name
    response = merchant_repository.find_by_merchant_name('Schroeder-Jerde')
    assert_equal 'Schroeder-Jerde', response.name
  end

  def test_it_finds_by_merchant_id
    response = merchant_repository.find_by_merchant_id('3')
    assert_equal '3', response.id
  end

  def test_it_finds_by_merchant_created_at
    response = merchant_repository.find_by_merchant_created_at('2012-03-27 14:53:59 UTC')
    assert_equal '2012-03-27 14:53:59 UTC', response.created_at
  end

  def test_it_finds_all_by_merchant_created_at
    response = merchant_repository.find_all_by_merchant_created_at('2012-03-27 14:53:59 UTC')
    assert_equal 6, response.count
    response.each { |merchant| assert_equal '2012-03-27 14:53:59 UTC', merchant.created_at }
  end

  def test_it_finds_by_merchant_updated_at
    response = merchant_repository.find_by_merchant_updated_at('2012-03-27 14:53:59 UTC')
    assert_equal '2012-03-27 14:53:59 UTC', response.updated_at
  end

  def test_it_finds_all_by_merchant_updated_at
    response = merchant_repository.find_all_by_merchant_updated_at('2012-03-27 14:53:59 UTC')
    assert_equal 6, response.count
    response.each { |merchant| assert_equal '2012-03-27 14:53:59 UTC', merchant.updated_at }
  end

  def test_it_finds_by_all
    response = merchant_repository.all
    assert_equal 6, response.count
  end

end
  
