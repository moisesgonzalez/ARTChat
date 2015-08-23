require 'socket'

port = 8081
print "Opening port ", port, "\n"

# Open server on port 8081
server = TCPServer.new port
loop do
  Thread.start(server.accept) do |client|
    client.puts "Hi from Arteko"
    sleep(3)
    client.puts "I said hello"
    sleep(3)
    client.puts "Helllloooooooo"
    sleep(4)
    client.puts "CAN YOU HEAR ME?"
    sleep(5)
    client.puts "You better answer!!"
    sleep(2)
    client.puts "Im out!!"
    client.close
  end
end

