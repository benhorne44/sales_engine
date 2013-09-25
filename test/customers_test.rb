require 'csv'
require 'minitest'
require 'minitest/autorun'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'

class CustomerTest < MiniTest::Test
  def setup
    customer_data = CSV.read'./data/customers_test.csv', headers: true, header_converters: :symbol
    @customer = Customer.new
  end
end

class CustomerRepositoryTest < MiniTest::Test

  def setup
    @customer_data = CSV.read'./data/customers_test.csv', headers: true, header_converters: :symbol
    @cr = CustomerRepository.new
    @cr.load_file('./data/customers_test.csv')
  end

  def test_it_gives_random_customer
    match = 0
    20.times  do
      response = @cr.random["customer_id"]
      expected = @cr.random['customer_id']
      if response == expected
        match += 1
      end
    end
    assert_operator match, :<, 20
  end

  def test_it_finds_all_by_first_name
    response = @cr.find_all_by_first_name('Joey')
    assert_equal 2, response.count
  end

  def test_it_finds_one_by_first_name
    response = @cr.find_by_first_name('Joey')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_last_name
    response = @cr.find_all_by_last_name('Ondricka')
    assert_equal 2, response.count
  end

  def test_it_finds_one_by_last_name
    response = @cr.find_by_last_name('Ondricka')
    assert_equal 1, response.count
  end

  def test_it_finds_by_customer_id
    response = @cr.find_by_customer_id('3')
    assert_equal 1, response.count
  end

  def test_it_finds_by_customer_created_at
    response = @cr.find_by_customer_created_at('2012-03-27 14:54:09 UTC')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_customer_created_at
    response = @cr.find_all_by_customer_created_at('2012-03-27 14:54:09 UTC')
    assert_equal 2, response.count
  end

  def test_it_finds_by_customer_updated_at
    response = @cr.find_by_customer_updated_at('2012-03-27 14:54:09 UTC')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_customer_updated_at
    response = @cr.find_all_by_customer_updated_at('2012-03-27 14:54:09 UTC')
    assert_equal 2, response.count
  end

  def test_it_finds_by_all
    response = @cr.all
    assert_equal 4, response.count    
  end
end
  
