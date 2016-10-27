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
    hobby = gets.chop
    puts "Where do they come from?"
    origin = gets.gsub("\n", "")
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
    puts "Now we have #{students.count} student#{if (students.count) > 1 then "s" end}. If you want to add more, write their name. Otherwise just hit return/enter button."
    name = gets.chomp
  end
  students
end

students = input_students
$line_width = 60

def print_header
  puts "The Students of Cartoons Academy".center($line_width)
  puts "---------".center($line_width)
end

def print(students)
  (students.sort_by {|p| p[:cohort]}).each.with_index do |student, index|
    if (student[:name].downcase.start_with?("p")) && (student[:name].length < 12)
        puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort, hobby: #{student[:hobby]}, origin: #{student[:origin]}, pony? #{student[:pony] ? "yes" : "no"})"
    end
  end
end

def pcohorts(students)
  cohorts = []
  students.each {|student| if !(cohorts.include? student[:cohort]) then cohorts << student[:cohort] end}
  cohorts.each do |cohort|
    puts cohort.to_s.upcase + ":"
    n = 1
    students.each do |student|
      if student[:cohort] == cohort
        puts "#{n}. #{student[:name]} (hobby: #{student[:hobby]}, origin: #{student[:origin]}, pony? #{student[:pony] ? "yes" : "no"})"
        n += 1
      end
    end
  end
end


def print_footer(students)
  puts "#{students.count} amazing student#{if (students.count) > 1 then "s" end} attend#{if (students.count) == 1 then "s" end} our academy <3".center($line_width)
end

print_header
puts "Would you like a messy or a neat list? (messy/neat)"
list = gets.chomp
if list == "messy"
  print(students)
elsif list == "neat"
  pcohorts(students)
else
  puts "I didn't get that. I will print you a neat list:"
  pcohorts(students)
end
print_footer(students)
