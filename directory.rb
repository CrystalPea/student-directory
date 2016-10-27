require "date"

def input_students
  puts "Please enter the names of the students."
  puts "To finish, just hit return/enter twice"
  students = []
  name = gets.chomp
  while !name.empty? do
    puts "What cohort are they in?"
    cohort = gets.chomp
    if (cohort != nil) && ((Date::MONTHNAMES).include? cohort.capitalize)
      cohort = cohort.downcase.to_sym
    else cohort = :unknown
    end
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
    students << {name: name, cohort: cohort, hobby: hobby, origin: origin, pony: pony}
    puts "Now we have #{students.count} students. If you want to add more, write their name. Otherwise just hit return/enter button."
    name = gets.chomp
  end
  students
end

students = input_students
$line_width = 60

def print_header
  puts "The Students of Cartoons Academy".center($line_width)
  puts "---------"
end

def print(students)
  n = 0
  while students[n] != nil
    if ((students[n])[:name].downcase.start_with?("p")) && ((students[n])[:name].length < 12)
      puts "#{n + 1}. #{(students[n])[:name]} (#{(students[n])[:cohort]} cohort, hobby: #{(students[n])[:hobby]}, origin: #{(students[n])[:origin]}, pony? #{(students[n])[:pony] ? "yes" : "no"})"
    end
    n += 1
  end
end

def print_footer(students)
  puts "#{students.count} amazing students attend our academy <3".center($line_width)
end

print_header
print(students)
print_footer(students)
