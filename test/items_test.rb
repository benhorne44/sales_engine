require 'csv'
require 'minitest'
require 'minitest/autorun'
require_relative '../lib/item_repository'
require_relative '../lib/item'

class ItemTest < MiniTest::Test
  def setup
    item_data = CSV.read'../data/items_test.csv', headers: true, header_converters: :symbol
    @item = Item.new
  end

end

class ItemRepositoryTest < MiniTest::Test
  def setup
    @item_data = CSV.read'../data/items_test.csv', headers: true, header_converters: :symbol
    @i = ItemRepository.new
  end

  def test_it_loads_file
    response = @i.load_file('../data/items_test.csv')
    assert_equal @item_data, response
  end

  def test_it_formats_item_data
    @i.load_file('../data/items_test.csv')
    response = @i.format_item_data_into_hash
    @expected = {"item_id"=>"2481", "item_name"=>"Item Sit Esse", "item_description"=>"Natus soluta qui consequatur repellat beatae aspernatur. Qui fuga sed velit. Vitae rerum suscipit quidem sed unde.", "unit_price"=>"92637", "merchant_id"=>"100", "item_created_at"=>"2012-03-27 14:54:09 UTC", "item_updated_at"=>"2012-03-27 14:54:09 UTC"}, {"item_id"=>"2482", "item_name"=>"Item Sint Et", "item_description"=>"Sed blanditiis consequuntur. Nihil excepturi nesciunt sit quaerat ad et. Ut ut debitis ad unde aliquid. Eum eaque voluptatum quia libero.", "unit_price"=>"50000", "merchant_id"=>"100", "item_created_at"=>"2012-03-27 14:54:09 UTC", "item_updated_at"=>"2012-03-27 14:54:09 UTC"}, {"item_id"=>"2483", "item_name"=>"Item Fuga Est", "item_description"=>"Vitae nostrum esse sequi reprehenderit error sint quia. Voluptas rem quam eaque dolores dolorem dolor. Deleniti officiis cum eum commodi assumenda animi dolores. Nisi vel consequatur minus itaque officiis sit quae. Accusamus ut voluptas perspiciatis.", "unit_price"=>"30467", "merchant_id"=>"100", "item_created_at"=>"2012-03-27 14:54:09 UTC", "item_updated_at"=>"2012-03-27 14:54:09 UTC"}
    assert_equal @expected, response
  end

  def test_it_gives_random_invoice_item
    @i.load_file('../data/items_test.csv')
    response = @i.random["item_id"]
    expected = @i.random['item_id']
 
    refute_equal response, expected
    # assert_operator match, :<, 20
  end

  # def test_it_gives_random_customer
  #   assert
  # end

end
  
