require 'csv'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository'
require_relative '../lib/item'

class ItemTest < MiniTest::Test
  def setup
    item_data = CSV.read'./data/items_test.csv', headers: true, header_converters: :symbol
    @item = Item.new
  end

end

class ItemRepositoryTest < MiniTest::Test
  def setup
    @item_data = CSV.read'./data/items_test.csv', headers: true, header_converters: :symbol
    @i = ItemRepository.new
    @i.load_file('./data/items_test.csv')
  end

  def test_it_gives_random_customer
    match = 0
    20.times  do
      response = @i.random["item_id"]
      expected = @i.random['item_id']
      if response == expected
        match += 1
      end
    end
    assert_operator match, :<, 20
  end

  def test_it_finds_all_by_item_name
    response = @i.find_all_by_item_name('Item Sit Esse')
    assert_equal 2, response.count
  end

  def test_it_finds_one_by_item_name
    response = @i.find_by_item_name('Item Sit Esse')
    assert_equal 1, response.count
  end

  def test_it_finds_by_item_id
    response = @i.find_by_item_id('2481')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_item_description
    response = @i.find_all_by_item_description('Natus soluta qui consequatur repellat beatae aspernatur. Qui fuga sed velit. Vitae rerum suscipit quidem sed unde.')
    assert_equal 2, response.count
  end

  def test_it_finds_one_by_item_description
    response = @i.find_by_item_description('Natus soluta qui consequatur repellat beatae aspernatur. Qui fuga sed velit. Vitae rerum suscipit quidem sed unde.')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_unit_price
    response = @i.find_all_by_unit_price('92637')
    assert_equal 2, response.count
  end

  def test_it_finds_one_by_unit_price
    response = @i.find_by_unit_price('92637')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_merchant_id
    response = @i.find_all_by_merchant_id('100')
    assert_equal 4, response.count
  end

  def test_it_finds_one_by_merchant_id
    response = @i.find_by_merchant_id('100')
    assert_equal 1, response.count
  end

  def test_it_finds_by_item_created_at
    response = @i.find_by_item_created_at('2012-03-27 14:54:09 UTC')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_item_created_at
    response = @i.find_all_by_item_created_at('2012-03-27 14:54:09 UTC')
    assert_equal 4, response.count
  end

  def test_it_finds_by_item_updated_at
    response = @i.find_by_item_updated_at('2012-03-27 14:54:09 UTC')
    assert_equal 1, response.count
  end

  def test_it_finds_all_by_item_updated_at
    response = @i.find_all_by_item_updated_at('2012-03-27 14:54:09 UTC')
    assert_equal 4, response.count
  end

  def test_it_finds_by_all
    response = @i.all
    assert_equal 4, response.count    
  end
end
  
