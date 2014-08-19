require File.dirname(__FILE__) +'/rewriter'

while true
  puts "Enter a roman numeral or enter nothing to exit the loop."
  numeral = readline().strip.upcase
  break if numeral.empty?
  r = Rewriter.new()
  begin
    puts r.scan(numeral)
  rescue Exception => e
    puts e.message
  end
end
