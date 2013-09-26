require 'csv'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class MerchantTest < MiniTest::Test
  def setup
    merchant_data = CSV.read'./data/merchants_test.csv', headers: true, header_converters: :symbol
    @merchant = Merchant.new
  end

end

class MerchantRepositoryTest < MiniTest::Test
  
  def repo
    @repo ||= load_data
  end

  def load_data
    mr = MerchantRepository.new
    mr.load_file('./data/merchants_test.csv')
    return mr
  end

  def test_it_gives_random_merchant
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

  def test_it_finds_all_by_merchant_name
    response = repo.find_all_by_merchant_name('Schroeder-Jerde')
    assert_equal 2, response.count
    response.each { |merchant| assert_equal 'Schroeder-Jerde', merchant.name }
  end

  def test_it_finds_one_by_merchant_name
    response = repo.find_by_merchant_name('Schroeder-Jerde')
    assert_equal 'Schroeder-Jerde', response.name
  end

  def test_it_finds_by_merchant_id
    response = repo.find_by_merchant_id('3')
    assert_equal '3', response.id
  end

  def test_it_finds_by_merchant_created_at
    response = repo.find_by_merchant_created_at('2012-03-27 14:53:59 UTC')
    assert_equal '2012-03-27 14:53:59 UTC', response.created_at
  end

  def test_it_finds_all_by_merchant_created_at
    response = repo.find_all_by_merchant_created_at('2012-03-27 14:53:59 UTC')
    assert_equal 4, response.count
    response.each { |merchant| assert_equal '2012-03-27 14:53:59 UTC', merchant.created_at }
  end

  def test_it_finds_by_merchant_updated_at
    response = repo.find_by_merchant_updated_at('2012-03-27 14:53:59 UTC')
    assert_equal '2012-03-27 14:53:59 UTC', response.updated_at
  end

  def test_it_finds_all_by_merchant_updated_at
    response = repo.find_all_by_merchant_updated_at('2012-03-27 14:53:59 UTC')
    assert_equal 4, response.count
    response.each { |merchant| assert_equal '2012-03-27 14:53:59 UTC', merchant.updated_at }
  end

  def test_it_finds_by_all
    response = repo.all
    assert_equal 4, response.count    
  end

end
  
