class Enigma
  attr_reader :alphabet

  def initialize
    @alphabet = ("a".."z").to_a << " "
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

  def offsets(date = Date.today.strftime("%d%m%Y"))
    date_sqrd = date.to_i * date.to_i
    four_digit = date_sqrd.to_s[-4..-1]
    offsets_hash = {}
    generator = four_digit.split('')
    offsets_hash[:a] = (generator[0])
    offsets_hash[:b] = (generator[1])
    offsets_hash[:c] = (generator[2])
    offsets_hash[:d] = (generator[3])
    return offsets_hash
  end

  def shifts(keys_input, offsets_input)
    shifts = {}
    shift_keys(keys_input).each do |key, value|
      offsets(offsets_input).each do |off_key, off_value|
        if key == off_key
          shifts[key] = (value.to_i + off_value.to_i).to_s
        end
      end
    end
    shifts
  end

end
