require 'csv'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative '../lib/sales_engine'


class ItemRepositoryTest < MiniTest::Test
  
  def setup
    @engine ||= SalesEngine.new
    @engine.item_repository.load_file('./data/items_test.csv')
  end

  def repo
    @engine.item_repository 
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

  def test_it_finds_all_by_item_name
    response = repo.find_all_by_item_name('Item Sit Esse')
    assert_equal 2, response.count
    response.each { |item| assert_equal 'Item Sit Esse', item.name }
  end

  def test_it_finds_one_by_item_name
    response = repo.find_by_item_name('Item Sit Esse')
    assert_equal 'Item Sit Esse', response.name
  end

  def test_it_finds_by_item_id
    response = repo.find_by_item_id('2481')
    assert_equal '2481', response.id
  end

  def test_it_finds_all_by_item_description
    response = repo.find_all_by_item_description('Natus soluta qui consequatur repellat beatae aspernatur. Qui fuga sed velit. Vitae rerum suscipit quidem sed unde.')
    assert_equal 2, response.count
    response.each { |item| assert_equal 'Natus soluta qui consequatur repellat beatae aspernatur. Qui fuga sed velit. Vitae rerum suscipit quidem sed unde.', item.description }
  end

  def test_it_finds_one_by_item_description
    response = repo.find_by_item_description('Natus soluta qui consequatur repellat beatae aspernatur. Qui fuga sed velit. Vitae rerum suscipit quidem sed unde.')
    assert_equal 'Natus soluta qui consequatur repellat beatae aspernatur. Qui fuga sed velit. Vitae rerum suscipit quidem sed unde.', response.description
  end

  def test_it_finds_all_by_unit_price
    response = repo.find_all_by_unit_price('92637')
    assert_equal 2, response.count
    response.each { |item| assert_equal '92637', item.unit_price }
  end

  def test_it_finds_one_by_unit_price
    response = repo.find_by_unit_price('92637')
    assert_equal '92637', response.unit_price
  end

  def test_it_finds_all_by_merchant_id
    response = repo.find_all_by_merchant_id('100')
    assert_equal 4, response.count
    response.each { |item| assert_equal '100', item.merchant_id }
  end

  def test_it_finds_one_by_merchant_id
    response = repo.find_by_merchant_id('100')
    assert_equal '100', response.merchant_id
  end

  def test_it_finds_by_item_created_at
    response = repo.find_by_item_created_at('2012-03-27 14:54:09 UTC')
    assert_equal '2012-03-27 14:54:09 UTC', response.created_at
  end

  def test_it_finds_all_by_item_created_at
    response = repo.find_all_by_item_created_at('2012-03-27 14:54:09 UTC')
    assert_equal 4, response.count
    response.each { |item| assert_equal '2012-03-27 14:54:09 UTC', item.created_at }
  end

  def test_it_finds_by_item_updated_at
    response = repo.find_by_item_updated_at('2012-03-27 14:54:09 UTC')
    assert_equal '2012-03-27 14:54:09 UTC', response.updated_at
  end

  def test_it_finds_all_by_item_updated_at
    response = repo.find_all_by_item_updated_at('2012-03-27 14:54:09 UTC')
    assert_equal 4, response.count
    response.each { |item| assert_equal '2012-03-27 14:54:09 UTC', item.updated_at }
  end

  def test_it_finds_by_all
    response = repo.all
    assert_equal 4, response.count    
  end
end
  
