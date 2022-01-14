require "./lib/message_generator"

def start
  message_generator = MessageGenerator.new
  message_generator.encrypt_message
end

start
