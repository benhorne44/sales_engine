require 'csv'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class CustomerRepositoryTest < MiniTest::Test

  def setup
    @engine ||= SalesEngine.new
    @engine.customer_repository.load_file('./data/customers_test.csv')
  end

  def customer_repository
    @engine.customer_repository 
  end

  def test_it_gives_random_customer
    match = 0
    20.times  do
      response = customer_repository.random
      expected = customer_repository.random
      if response == expected
        match += 1
      end
    end
    assert_operator match, :<, 20
  end

  def test_it_finds_all_by_first_name
    response = customer_repository.find_all_by_first_name('Joey')
    assert_equal 2, response.count
    response.each { |customer| assert_equal 'Joey', customer.first_name }
  end

  def test_it_finds_one_by_first_name
    response = customer_repository.find_by_first_name('Joey')
    assert_equal 'Joey', response.first_name
  end

  def test_it_finds_all_by_last_name
    response = customer_repository.find_all_by_last_name('Ondricka')
    assert_equal 2, response.count
    response.each { |customer| assert_equal 'Ondricka', customer.last_name }
  end

  def test_it_finds_one_by_last_name
    response = customer_repository.find_by_last_name('Ondricka')
    assert_equal 'Ondricka', response.last_name
  end

  def test_it_finds_by_customer_id
    response = customer_repository.find_by_id(3)
    assert_equal 3, response.id
  end

  def test_it_finds_by_customer_created_at
    response = customer_repository.find_by_created_at('2012-03-27 14:54:09 UTC')
    assert_equal '2012-03-27 14:54:09 UTC', response.created_at
  end

  def test_it_finds_all_by_customer_created_at
    response = customer_repository.find_all_by_created_at('2012-03-27 14:54:09 UTC')
    assert_equal 2, response.count
    response.each { |customer| assert_equal '2012-03-27 14:54:09 UTC', customer.created_at }
  end

  def test_it_finds_by_customer_updated_at
    response = customer_repository.find_by_updated_at('2012-03-27 14:54:09 UTC')
    assert_equal '2012-03-27 14:54:09 UTC', response.updated_at
  end

  def test_it_finds_all_by_customer_updated_at
    response = customer_repository.find_all_by_updated_at('2012-03-27 14:54:09 UTC')
    assert_equal 2, response.count
    response.each { |customer| assert_equal '2012-03-27 14:54:09 UTC', customer.updated_at }
  end

  def test_it_finds_by_all
    response = customer_repository.all
    assert_equal 4, response.count    
  end
end
  
