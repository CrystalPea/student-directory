#student list as an array
students = [
{name: "Twilight Sparkle", cohort: :november},
{name: "Rainbow Dash", cohort: :november},
{name: "Pinkie Pie", cohort: :november},
{name: "Pearl", cohort: :november},
{name: "Steven Universe", cohort: :november},
{name: "Kony", cohort: :november},
{name: "Marco", cohort: :november},
{name: "Star Butterfly", cohort: :november},
{name: "Ami Mizuno", cohort: :november},
{name: "Princess Bubblegum", cohort: :november},
{name: "Marceline The Vampire Queen", cohort: :november},
{name: "Dexter", cohort: :november}]

def print_header
  puts "The Students of Cartoons Academy"
  puts "---------"
end

def print(students)
  students.each {|student| puts "#{student[:name]} (#{student[:cohort]} cohort)"}
end

def print_footer(students)
  puts "#{students.count} amazing students attend our academy <3"
end

print_header
print(students)
print_footer(students)
