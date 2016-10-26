#student list as an array
students = [
"Twilight Sparkle",
"Rainbow Dash",
"Pinkie Pie",
"Pearl",
"Steven Universe",
"Kony",
"Marco",
"Star Butterfly",
"Ami Mizuno",
"Princess Bubblegum",
"Marceline The Vampire Queen",
"Dexter"]

def print_header
  puts "The Students of Cartoons Academy"
  puts "---------"
end

def print(names)
  names.each {|name| puts name}
end

def print_footer(names)
  puts "#{names.count} amazing students attend our academy <3"
end

print_header
print(students)
print_footer(students)
