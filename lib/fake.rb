
class Cats
  def initialize(id)
    @id = id
  end
  def has_owner
    return 'no'
  end
end

class Dogs
  def initialize(id)
    @id = id
  end
  def has_owner
    return 'yes'
  end
end

class Owner
  def initialize(pet_id)
    @pet_id = pet_id
  end

  def has_pets
    if @pet_id == 2
      puts "Has a cat"
    end
  end
end



  e = Cats.new(2)
  puts e
  d = Owner.new(2)
  puts d
