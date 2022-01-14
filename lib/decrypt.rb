require './lib/enigma'
require 'date'
require 'pry'

enigma = Enigma.new
encrypted_file = ARGV[0]
decrypted_file = ARGV[1]
message_key = ARGV[2]
message_date = ARGV[3]

message = File.read(encrypted_file).chomp

decrypted_message = enigma.decrypt(message, message_key, message_date)
File.open('decrypted.txt', "w") {|f| f.write "#{decrypted_message[:decryption]}"}
puts "Created #{decrypted_file} with the key #{decrypted_message[:key]} and date #{decrypted_message[:date]}"
