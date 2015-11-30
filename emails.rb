require 'json'

file = File.read ARGV[0]
json = JSON.parse file
emails = json['participants'].map do |part|
  if part['groups']['viikko07']['points'] > 0
    part['email']
  else
    ""
  end
end
#emails = file.split("\n").map{|e| e.split(",")[0]}


f = File.open ARGV[1], "w+"
f.write emails.join("\n")

f.close
puts "Done"

