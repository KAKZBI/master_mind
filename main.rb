require_relative "./lib/game.rb"

master_mind = Game.new
puts "Welcome to the Master Mind game"
master_mind.start
begin
  master_mind.run
  puts master_mind.result
rescue PermanentFailureError => e 
  puts e.message
  exit(1)
end