def input_students
  puts "Please enter the names of the students."
  puts "To finish, just hit return/enter twice"
  students = []
  name = gets.chomp
  while !name.empty? do
    puts "What's their hobby?"
    hobby = gets.chomp
    puts "Where do they come from?"
    origin = gets.chomp
    puts "Are they a pony? (yes/no)"
    pony = gets.chomp
    if pony.downcase == "yes"
      pony = true
    elsif pony.downcase == "no"
      pony = false
    else puts "I didn't catch that. I will assume that they are not a pony."
      pony = false
    end
    students << {name: name, cohort: :november, hobby: hobby, origin: origin, pony: pony}
    puts "Now we have #{students.count} students."
    name = gets.chomp
  end
  students
end

students = input_students

def print_header
  puts "The Students of Cartoons Academy"
  puts "---------"
end

def print(students)
  n = 0
  while students[n] != nil
    if ((students[n])[:name].downcase.start_with?("p")) && ((students[n])[:name].length < 12)
      puts "#{n + 1}. #{(students[n])[:name]} (#{(students[n])[:cohort]} cohort)"
    end
    n += 1
  end
end

def print_footer(students)
  puts "#{students.count} amazing students attend our academy <3"
end

print_header
print(students)
print_footer(students)
