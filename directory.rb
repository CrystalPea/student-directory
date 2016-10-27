require "date"
#a method for inputing students and data about the students:
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

#variables needed for methods below to work
students = input_students
$line_width = 60

#a method for printing list header
def print_header
  puts "The Students of Cartoons Academy".center($line_width)
  puts "---------"
end

#a "messier" method for printing student list. It includes filters that make it print only 
#some students based on first letter of their name and number of characters in their name
def print(students)
  (students.sort_by {|p| p[:cohort]}).each.with_index do |student, index|
    if (student[:name].downcase.start_with?("p")) && (student[:name].length < 12)
        puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort, hobby: #{student[:hobby]}, origin: #{student[:origin]}, pony? #{student[:pony] ? "yes" : "no"})"
    end
  end
end

#Below method prints students into separate lists depending on their cohort.
#You can also choose to only see students from your chosen cohorts.
def pcohorts(students)
  cohorts = []
  students.each {|student| if !(cohorts.include? student[:cohort]) then cohorts << student[:cohort] end}
  puts "Would you like to filter the students you see by cohort? (yes/no)"
  answer = gets.chomp
  if answer == "yes"
    puts "Which cohort would you like to print?"
    filter = gets.chomp
    if (filter != nil) && ((Date::MONTHNAMES).include? filter.capitalize)
      puts filter.to_s.upcase + ":"
      m = 0
      students.each do |student|
        if student[:cohort] == filter
          puts "#{m}. #{student[:name]} (hobby: #{student[:hobby]}, origin: #{student[:origin]}, pony? #{student[:pony] ? "yes" : "no"})"
          m += 1
        end
      end
    else puts "I didn't understand that. You will have to try again."
    end
  else
    puts "You wanted to see all the cohorts, right?"
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
end

#a method for printing the footer of the list:
def print_footer(students)
  puts "#{students.count} amazing student#{if (students.count) > 1 then "s" end} attend#{if (students.count) == 1 then "s" end} our academy <3".center($line_width)
end


#a method for printing all the list, together with header and footer.
def print_list(students)
  if students != []
    print_header
    puts "Would you like a messy list or a neat one that can filter by cohort? (messy/neat)"
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
  end
end

print_list(students)
