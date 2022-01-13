class Enigma
  attr_reader :alphabet

  def initialize
    @alphabet = ("a".."z").to_a << " "
  end

  def shift(key, offset)
    key + offset
  end

  def shift_keys(random_num = rand(0..99999))
    five_digit = random_num.to_s.rjust(5, '0')
    keys_hash = {}
    generator = five_digit.split('')
    keys_hash[:a] = (generator[0] + generator[1])
    keys_hash[:b] = (generator[1] + generator[2])
    keys_hash[:c] = (generator[2] + generator[3])
    keys_hash[:d] = (generator[3] + generator[4])
    return keys_hash
  end



end
