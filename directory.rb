require "date"
@students = []

#variables needed for methods below to work
$line_width = 60

#a method for inputing students and data about the students:
def input_students
  puts "Please enter the names of the students."
  puts "To finish, just hit return/enter twice"
  @students = []
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
    @students << {name: name, cohort: cohort, hobby: hobby, origin: origin, pony: pony}
    puts "Now we have #{@students.count} student#{if (@students.count) > 1 then "s" end}. If you want to add more, write their name. Otherwise just hit return/enter button."
    name = gets.chomp
  end
  @students
end

#a method for printing list header
def print_header
  puts ""
  puts "The Students of Cartoons Academy".center($line_width)
  puts "---------".center($line_width)
end

#a method for printing the list footer:
def print_footer
  puts "#{@students.count} amazing student#{if (@students.count) > 1 then "s" end} attend#{if (@students.count) == 1 then "s" end} our academy <3".center($line_width)
end

#Method for filtering students by letter
def letter_filter
  filtered = []
  loop do
    puts "What letter? Press return button twice if you changed your mind."
    letter = gets.chomp
    if letter.length == 1
      @students.each {|student| if (student[:name].downcase.start_with?(letter.downcase)) then filtered << student end}
      return filtered
    elsif letter.length == 0
      break
    else puts "Please enter exactly one letter."
    end
  end
end

#Method for filtering students by character count
def cc_filter
  filtered = []
  loop do
    puts "What is the max character count allowed? Press return button twice if you changed your mind."
    cc = gets.chomp
    if (cc.to_i).is_a? Integer
      @students.each {|student| if (student[:name].length < (cc.to_i)) then filtered << student end}
      return filtered
    elsif cc.length == 0
      break
    else puts "Please enter a number value."
    end
  end
end

#here be double filter method
def double_filter
maxchar = cc_filter
letfil = letter_filter
filtered = []
@students.each {|student| if ((maxchar.include? student) && (letfil.include? student)) then filtered << student end}
filtered
end


#method for filtering menu
def filter_ask
  students = @students
  loop do
    puts "Would you like to filter students by first letter of their name or character count?\n1. by name\n2.by character count\n3.both\n4.none"
    filter = gets.chomp
    if filter == "1"
     return students = letter_filter
    elsif filter == "2"
      return students = cc_filter
    elsif filter == "3"
      return students = double_filter
    elsif filter == "4"
      puts "Well noted."
      break
    else puts "Please enter a valid answer"
    end
  end
  students
end

#Below method prints students into separate lists depending on their cohort.
#You can also choose to only see students from your chosen cohorts.
def pcohorts
  students = filter_ask
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
def print_list
  if @students != []
    pcohorts
    print_footer
  else puts "No students to print."
  end
end

#A method for printing our interactive menu
def print_menu
  puts "Welcome to student directory. What would you like to do today?
  \n 1. Input students
  \n 2. Print student list
  \n 9. Exit"
end

#An interactive menu to, well, interact with our program :)
def interactive_menu
  loop do
    print_menu
    answer = gets.chomp
    case answer
    when "1"
      @students = input_students
    when "2"
      print_list
    when "9"
      break
    else puts "Please enter a number corresponding to your desired action."
    end
  end
end

interactive_menu