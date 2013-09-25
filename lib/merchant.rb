class Merchant
  attr_reader :id, :name, :created_at, :updated_at
 
  def initialize(input)
    @id = input[:id]
    @name = input[:name]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
  end

  def id
    @id
  end

  def name
    @name
  end

  def created_at
    @created_at
  end

  def updated_at
    @updated_at
  end

end
