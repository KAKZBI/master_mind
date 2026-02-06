require_relative "./lib/game.rb"

puts "Welcome to the Master Mind game"

begin
  master_mind = Game.new
  master_mind.start
  master_mind.run
  puts master_mind.result
rescue PermanentFailureError => e 
  puts e.message
  exit(1)
end