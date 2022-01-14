require './lib/enigma'
require 'date'
require 'pry'

enigma = Enigma.new
message_file = ARGV[0]
encrypted_file = ARGV[1]
message = File.read(message_file).chomp

encrypted_message = enigma.encrypt(message)
File.open('encrypted.txt', "w") {|f| f.write "#{encrypted_message[:encryption]}"}
puts "Created #{encrypted_file} with the key #{encrypted_message[:key]} and date #{encrypted_message[:date]}"
