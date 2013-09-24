require 'csv'
require 'minitest'
require 'minitest/autorun'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class MerchantTest < MiniTest::Test
  def setup
    merchant_data = CSV.read'../data/merchants_test.csv', headers: true, header_converters: :symbol
    @merchant = Merchant.new
  end

end

class MerchantRepositoryTest < MiniTest::Test
  def setup
    @merchant_data = CSV.read'../data/merchants_test.csv', headers: true, header_converters: :symbol
    @m = MerchantRepository.new
  end

  def test_it_loads_file
    response = @m.load_file('../data/merchants_test.csv')
    assert_equal @merchant_data, response
  end

  def test_it_formats_merchant_data
    @m.load_file('../data/merchants_test.csv')
    response = @m.format_merchant_data_into_hash
    @expected = {"merchant_id"=>"1", "merchant_name"=>"Schroeder-Jerde", "merchant_created_at"=>"2012-03-27 14:53:59 UTC", "merchant_updated_at"=>"2012-03-27 14:53:59 UTC"}, {"merchant_id"=>"2", "merchant_name"=>"Klein, Rempel and Jones", "merchant_created_at"=>"2012-03-27 14:53:59 UTC", "merchant_updated_at"=>"2012-03-27 14:53:59 UTC"}, {"merchant_id"=>"3", "merchant_name"=>"Willms and Sons", "merchant_created_at"=>"2012-03-27 14:53:59 UTC", "merchant_updated_at"=>"2012-03-27 14:53:59 UTC"}
    assert_equal @expected, response
  end

  def test_it_gives_random_merchant
    @m.load_file('../data/merchants_test.csv')
    response = @m.random["merchant_id"]
    expected = @m.random['merchant_id']
 
    refute_equal response, expected
    # assert_operator match, :<, 20
  end

  # def test_it_gives_random_customer
  #   assert
  # end

end
  
