require "date"

#variables needed for methods below to work
$line_width = 60

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

#a method for printing list header
def print_header
  puts ""
  puts "The Students of Cartoons Academy".center($line_width)
  puts "---------".center($line_width)
end

#a method for printing the footer of the list:
def print_footer(students)
  puts "#{students.count} amazing student#{if (students.count) > 1 then "s" end} attend#{if (students.count) == 1 then "s" end} our academy <3".center($line_width)
end

#a "messier", older method for printing student list. It includes filters that make it print only 
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
  loop do
    puts "Would you like to filter the students you see by cohort?
    \n1. yes
    \n2. no"
    answer = gets.chomp
    if answer == "1"
      puts "Which cohort would you like to print?"
      puts "You can choose from: #{cohorts.join(", ")}"
      filter = gets.chomp
      if (filter != nil) && ((Date::MONTHNAMES).include? filter.capitalize)
        print_header
        puts filter.upcase + ":"
        m = 1
        students.each do |student|
          if student[:cohort] == filter.downcase.to_sym
            puts "#{m}. #{student[:name]} (hobby: #{student[:hobby]}, origin: #{student[:origin]}, pony? #{student[:pony] ? "yes" : "no"})"
            m += 1
          end
        end
        if m == 1 then puts "Sorry, no students in this cohort." end
        break
      else puts "I didn't understand that. You will have to try again."
      end
    elsif answer == "2"
      puts "You wanted to see all the cohorts, right? I got you:"
      print_header
      cohorts.each do |cohort|
        puts cohort.to_s.upcase + ":"
        n = 1
        students.each do |student|
          if student[:cohort] == cohort
            puts "#{n}. #{student[:name]} (hobby: #{student[:hobby]}, origin: #{student[:origin]}, pony? #{student[:pony] ? "yes" : "no"})"
            n += 1
          end
        end
        puts ""
      end
      break
    else puts "Choose a valid option to close the loop."
    end
  end
end


#a method for printing all the list, together with header and footer.
def print_list(students)
  if students != []
    puts "Would you like a messy list or a neat one that can filter by cohort?
    \n1. messy
    \n2. neat"
    list = gets.chomp
    if list == "1"
      print(students)
    elsif list == "2"
      pcohorts(students)
    else
      puts "I didn't get that. I will print you a neat list:"
      pcohorts(students)
    end
    print_footer(students)
  else puts "No students to print."
  end
end

#An interactive menu to, well, interact with our program :)
def interactive_menu  
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "Welcome to student directory. What would you like to do today?
    \n 1. Input students
    \n 2. Print student list
    \n 9. Exit"
    # 2. read the input and save it into a variable
    answer = gets.chomp
    # 3. do what the user has asked
    case answer
    when "1"
      students = input_students
    when "2"
      print_list(students)
    when "9"
      break
    else puts "Please enter a number corresponding to your desired action."
    end
    # 4. repeat from step 1
  end
end

interactive_menu