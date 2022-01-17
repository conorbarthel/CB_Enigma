class Enigma
  attr_reader :alphabet, :alphabet_hash, :reverse_alphabet, :reverse_alphabet_hash

  def initialize
    @alphabet = ("a".."z").to_a << " "
    @reverse_alphabet = @alphabet.reverse
    @alphabet_hash = @alphabet.reduce({}) do |acc, letter|
      acc[letter] = @alphabet.index(letter)
      acc
    end
    @reverse_alphabet_hash = @reverse_alphabet.reduce({}) do |acc, letter|
      acc[letter] = @reverse_alphabet.index(letter)
      acc
    end
  end

  def five_digit(random_num)
    five_digit = random_num.to_s.rjust(5, '0')
  end

  def shift_keys(random_num)
    keys_hash = {}
    generator = five_digit(random_num)
    keys_hash[:a] = (generator[0] + generator[1])
    keys_hash[:b] = (generator[1] + generator[2])
    keys_hash[:c] = (generator[2] + generator[3])
    keys_hash[:d] = (generator[3] + generator[4])
    return keys_hash
  end

  def offsets(date)
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

  def encrypt(message, keys = rand(0..99999), date = Date.today.strftime("%d%m%y"))
    coded_message = {
                    :encryption => [],
                    :key => keys.to_s,
                    :date => date
                    }
    encrypt_shifts = shifts(keys, date)
    working_message = message.downcase.split("")
    counter = -1
    working_message.each do |letter|
      counter += 1
      rotated_alpha = letter if !(@alphabet.include?(letter))
      if counter % 4 == 0
        rotated_alpha = @alphabet.rotate(encrypt_shifts[:a].to_i)
      elsif counter % 4 == 1
        rotated_alpha = @alphabet.rotate(encrypt_shifts[:b].to_i)
      elsif counter % 4 == 2
        rotated_alpha = @alphabet.rotate(encrypt_shifts[:c].to_i)
      elsif counter % 4 == 3
        rotated_alpha = @alphabet.rotate(encrypt_shifts[:d].to_i)
      end
      character = @alphabet_hash[letter]
      shifted_letter = rotated_alpha[character]
      coded_message[:encryption] << shifted_letter
      coded_message[:encryption]
    end
    coded_message[:encryption] = coded_message[:encryption].join
    coded_message
  end

  def decrypt(message, keys, date = Date.today.strftime("%d%m%y"))
    decoded_message = {
                    :decryption => [],
                    :key => keys.to_s,
                    :date => date
                    }
    encrypt_shifts = shifts(keys, date)
    working_message = message.split("")
    counter = -1
    working_message.each do |letter|
      counter += 1
      rotated_alpha = letter if !(@reverse_alphabet.include?(letter))
      if counter % 4 == 0
        rotated_alpha = @reverse_alphabet.rotate(encrypt_shifts[:a].to_i)
      elsif counter % 4 == 1
        rotated_alpha = @reverse_alphabet.rotate(encrypt_shifts[:b].to_i)
      elsif counter % 4 == 2
        rotated_alpha = @reverse_alphabet.rotate(encrypt_shifts[:c].to_i)
      elsif counter % 4 == 3
        rotated_alpha = @reverse_alphabet.rotate(encrypt_shifts[:d].to_i)
      end
      character = @reverse_alphabet_hash[letter]
      shifted_letter = rotated_alpha[character]
      decoded_message[:decryption] << shifted_letter
      decoded_message[:decryption]
    end
    decoded_message[:decryption] = decoded_message[:decryption].join
    decoded_message
  end

  def num_away(target, letter)
    if (@alphabet.index(letter) - @alphabet.index(target)) >= 0
      (@alphabet.index(letter) - @alphabet.index(target))
    elsif (@alphabet.index(letter) - @alphabet.index(target)) < 0
      (@alphabet.index(" ") - @alphabet.index(target)) + (@alphabet.index("a") + @alphabet.index(letter) + 1)
    end
  end

  def crack_keys(message, date)
    cracked_keys = {}
    offsets(date).each do |off_key, off_value|
      cracked_shifts(message).each do |shift_key, shift_value|
        if shift_key == off_key
          cracked_keys[shift_key] = (-(off_value.to_i) + shift_value.to_i).to_s
          binding.pry
        end
      end
    end
    cracked_keys
  end

  def cracked_shifts(message)
    last_four = [-4, -3, -2, -1]
    cracked_shifts_hash = {}
    last_four.each do |idx|
      if (message.length - 1 - idx) % 4 == 0
        cracked_shifts_hash[:a] = num_away(message[idx], " ").to_s
      elsif (message.length - 1 - idx) % 4 == 1
        cracked_shifts_hash[:b] = num_away(message[idx], "e").to_s
      elsif (message.length - 1 - idx) % 4 == 2
        cracked_shifts_hash[:c] = num_away(message[idx], "n").to_s
      elsif (message.length - 1 - idx) % 4 == 3
        cracked_shifts_hash[:d] = num_away(message[idx], "d").to_s
      end
    end
    cracked_shifts_hash
  end

  def crack(message, date = Date.today.strftime("%d%m%y"))
    cracked_offsets = offsets(date)
    cracked_keys =
    decoded_message = {
                    :decryption => [],
                    :key => cracked_keys.to_s,
                    :date => date
                    }
    encrypt_shifts = cracked_shifts(message)
    working_message = message.split("")
    counter = -1
    working_message.each do |letter|
      counter += 1
      rotated_alpha = letter if !(@reverse_alphabet.include?(letter))
      if counter % 4 == 0
        rotated_alpha = @reverse_alphabet.rotate(encrypt_shifts[:a].to_i)
      elsif counter % 4 == 1
        rotated_alpha = @reverse_alphabet.rotate(encrypt_shifts[:b].to_i)
      elsif counter % 4 == 2
        rotated_alpha = @reverse_alphabet.rotate(encrypt_shifts[:c].to_i)
      elsif counter % 4 == 3
        rotated_alpha = @reverse_alphabet.rotate(encrypt_shifts[:d].to_i)
      end
      character = @reverse_alphabet_hash[letter]
      shifted_letter = rotated_alpha[character]
      decoded_message[:decryption] << shifted_letter
      decoded_message[:decryption]
    end
    decoded_message[:decryption] = decoded_message[:decryption].join
    decoded_message
  end
end
