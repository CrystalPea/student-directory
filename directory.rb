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
