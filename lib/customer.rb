class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

  def initialize(input)
    @id = input[:id]
    @first_name = input[:first_name]
    @last_name = input[:last_name]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
  end

  def first_name
    @first_name
  end

  def last_name
    @last_name
  end

  def id
    @id 
  end

  def created_at
    @created_at
  end

  def updated_at
    @updated_at
  end

end

