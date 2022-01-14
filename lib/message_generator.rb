require './lib/enigma'

class MessageGenerator
  def initialize()
    @message = gets.chomp
    @enigma = Enigma.new
  end

  def encrypt_message
    File.new('./message.txt')
    File.new('./encrypted.txt')
    encrypted_message = @enigma.encrypt(@message)
    File.open('message.txt', "w") {|f| f.write @message}
    File.open('encrypted.txt', "w") {|f| f.write "#{encrypt_message[:decryption]}"}
  end
end
