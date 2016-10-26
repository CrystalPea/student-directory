def input_students
  puts "Please enter the names of the students."
  puts "To finish, just hit return/enter twice"
  students = []
  name = gets.chomp
  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students."
    name = gets.chomp
  end
  students
end

students = input_students
=begin
[{name: "Twilight Sparkle", cohort: :november},
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
=end

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
