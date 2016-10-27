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
  students.each.with_index(1) do |student, index| 
    if (student[:name].downcase.start_with?("p")) && (student[:name].length < 12)
      puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer(students)
  puts "#{students.count} amazing students attend our academy <3"
end

print_header
print(students)
print_footer(students)
