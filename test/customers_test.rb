require 'csv'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'

class CustomerTest < MiniTest::Test
  def setup
    customer_data = CSV.read'./data/customers_test.csv', headers: true, header_converters: :symbol
    @customer = Customer.new
  end
end

class CustomerRepositoryTest < MiniTest::Test

  def repo    
    @repo ||= load_data
  end

  def load_data
    cr = CustomerRepository.new
    cr.load_file('./data/customers_test.csv')
    return cr
  end

  def test_it_gives_random_customer
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

  def test_it_finds_all_by_first_name
    response = repo.find_all_by_first_name('Joey')
    assert_equal 2, response.count
    response.each do |customer|
     assert_equal 'Joey', customer.first_name
    end
  end

  def test_it_finds_one_by_first_name
    response = repo.find_by_first_name('Joey')
    assert_equal 'Joey', response.first_name
  end

  def test_it_finds_all_by_last_name
    response = repo.find_all_by_last_name('Ondricka')
    assert_equal 2, response.count
    response.each do |customer|
      assert_equal 'Ondricka', customer.last_name
    end
  end

  def test_it_finds_one_by_last_name
    response = repo.find_by_last_name('Ondricka')
    assert_equal 'Ondricka', response.last_name
  end

  def test_it_finds_by_customer_id
    response = repo.find_by_customer_id('3')
    assert_equal '3', response.id
  end

  def test_it_finds_by_customer_created_at
    response = repo.find_by_customer_created_at('2012-03-27 14:54:09 UTC')
    assert_equal '2012-03-27 14:54:09 UTC', response.created_at
  end

  def test_it_finds_all_by_customer_created_at
    response = repo.find_all_by_customer_created_at('2012-03-27 14:54:09 UTC')
    assert_equal 2, response.count
    response.each do |customer|
      assert_equal '2012-03-27 14:54:09 UTC', customer.created_at
    end
  end

  def test_it_finds_by_customer_updated_at
    response = repo.find_by_customer_updated_at('2012-03-27 14:54:09 UTC')
    assert_equal '2012-03-27 14:54:09 UTC', response.updated_at
  end

  def test_it_finds_all_by_customer_updated_at
    response = repo.find_all_by_customer_updated_at('2012-03-27 14:54:09 UTC')
    assert_equal 2, response.count
    response.each do |customer|
      assert_equal '2012-03-27 14:54:09 UTC', customer.updated_at
    end
  end

  def test_it_finds_by_all
    response = repo.all
    assert_equal 4, response.count    
  end
end
  
