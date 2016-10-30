require "date"
require "csv"

#variables needed for methods below to work
$line_width = 60
@students = []

#a method for saving student list to file
def save_students
  puts "How would you like to name your students list? Hit return/enter button twice if you want to cancel."
  filename = STDIN.gets.chomp
  if filename != nil
    CSV.open("./lists/#{filename}.csv", "wb") do |csv|
      @students.each do |student|
        csv << [student[:name], student[:cohort], student[:hobby], student[:origin], student[:pony]]
      end
    end
    puts "Your student list has been succesfully saved to ./lists/#{filename}.csv"
  else puts "Your student list has NOT been saved."
  end
end

#a method for loading a file with a student list
def load_file
  if ((Dir["./lists/*.csv"]).length) == 0
    puts "Nothing to load sadly."
  else which = nil
    loop do
      puts "Input the path of the file you would like to load ...Or hit return twice to quit"
      puts (Dir["./lists/*.csv"].join("\n"))
      which = STDIN.gets.chomp
      if (Dir["./lists/*.csv"]).include? "#{which}"
        return which
      elsif which == ""
        puts "Ok, back to menu."
        break
      else puts "No file like this. Try again."
      end
    end
  end
  interactive_menu
end

#a method for trying to load student list file from arguments supplied by command line
def try_load_students
  filename = ARGV.first
  if (filename.nil?)
  return load_students 
  end
  if File.exists?(filename)
    puts "Succesfully loaded file #{filename}."
    load_students(filename)
  else
    puts "Sorry, file #{filename}, supplied via command line, doesn't exist."
    return load_students 
  end
end

#a method for clearing student list
def clear_list
  puts "There are students on the program's student list already. Would you like to clear the list before adding new student(s)? Input:\n'1' for yes\n'2' for no"
  loop do
    answer = STDIN.gets.chomp
    if answer == "1"
      puts "Program's student list succesfully cleared."
      return @students = []
    elsif answer == "2"
      puts "Program's student list has NOT been cleared."
      return
    else puts "Please enter '1' if you would like to clear student list or '2' if you would like to add to it."
    end
  end
end

#a method for loading a student list from a file
def load_students(filename = load_file)
  if @students != [] then clear_list end
  CSV.foreach("#{filename}") do |row|
      name, cohort, hobby, origin, pony = row
      @students << {name: name, cohort: cohort.to_sym, hobby: hobby, origin: origin, pony: pony.to_sym}
  end
    puts "Loaded #{@students.count} student#{if (@students.count) > 1 then "s" end} from #{filename}."
end

#a method for inputing students and data about the students:
def input_students
  if @students != [] then clear_list end
  puts "Please enter the names of the students. One name at a time, and then return button."
  puts "To finish, just hit return/enter twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    puts "What cohort are they in?"
    cohort = STDIN.gets.chomp.downcase
    unless (cohort != nil) && ((Date::MONTHNAMES).include? cohort.capitalize)
    cohort = "unknown"
    end
    puts "What's their hobby?"
    hobby = STDIN.gets.chop
    puts "Where do they come from?"
    origin = STDIN.gets.gsub("\n", "")
    puts "Are they a pony? (yes/no)"
    pony = STDIN.gets.chomp
    if (pony.downcase == "yes") || (pony.downcase == "no")
      pony = pony.downcase
    else puts "I didn't catch that. I will assume that they are not a pony."
      pony = "no"
    end
    @students << {name: name, cohort: cohort.to_sym, hobby: hobby, origin: origin, pony: pony.to_sym}
    puts "Now we have #{@students.count} student#{if (@students.count) > 1 then "s" end}. If you want to add more, write their name. Otherwise just hit return/enter button."
    name = STDIN.gets.chomp
  end
  puts "We have a total of #{@students.count} student#{if (@students.count) > 1 then "s" end} on our list."
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
  puts "#{@students.count} amazing student#{if (@students.count) > 1 then "s" end} attend#{if (@students.count) == 1 then "s" end} our academy <3\n".center($line_width)
end

#Method for filtering students by first letter of their name
def first_letter_filter
  filtered = []
  loop do
    puts "What letter? Press return button twice if you changed your mind."
    letter = STDIN.gets.chomp
    if letter.length == 1
      @students.each {|student| if (student[:name].downcase.start_with?(letter.downcase)) then filtered << student end}
      puts "Now only students whose name starts with #{letter} will be shown."
      return filtered
    elsif letter.length == 0
      puts "No first letter filter applied."
      return @students
    else puts "Please enter exactly one letter."
    end
  end
end

#Method for filtering students by character count
def cc_filter
  filtered = []
  loop do
    puts "What is the max character count allowed? Press return button twice if you changed your mind."
    cc = STDIN.gets.chomp
    if (cc.to_i).is_a? Integer
      @students.each {|student| if (student[:name].length <= (cc.to_i)) then filtered << student end}
      puts "Now only students whose name is no longer than #{cc} characters will be shown."
      return filtered
    elsif cc.length == 0
      puts "No character count filter applied."
      return @students
    else puts "Please enter a number value."
    end
  end
end

#here be double filter method
def double_filter
maxchar = cc_filter
letfil = first_letter_filter
filtered = []
@students.each {|student| if ((maxchar.include? student) && (letfil.include? student)) then filtered << student end}
filtered
end


#method for filtering menu
def filter_ask
  loop do
    puts "Would you like to filter students by first letter of their name or character count?\n'1' - by name\n'2' - by character count\n'3' - both\n'4' - none"
    filter = STDIN.gets.chomp
    case filter
    when "1"; return students = first_letter_filter
    when "2"; return students = cc_filter
    when "3"; return students = double_filter
    when "4"; puts "Well noted."
      return @students
    else puts "Please enter a valid answer"
    end
  end
end

#a method for filtering by cohort
def cohort_filter(students)
 cohorts = []
  students.each {|student| if !(cohorts.include? student[:cohort]) then cohorts << student[:cohort] end}
  loop do
    puts "Would you like to filter the students you see by cohort?\n'1' for yes\n'2' for no"
    answer = STDIN.gets.chomp
    if answer == "1"
      puts "Which cohort would you like to print?\nYou can choose from: #{cohorts.join(", ")}"
      filter = STDIN.gets.chomp.downcase
      if (filter != nil) && ((Date::MONTHNAMES).include? filter.capitalize)
        cohorts = []
        cohorts << filter.to_sym
        puts "Here you go, all students (allowed by your filters) from #{filter.capitalize} cohort:"
        break
      else puts "I didn't understand that. You will have to try again."
      end
    elsif answer == "2"
      puts "You wanted to see all the cohorts, right? I got you:"
      break
    else puts "Choose a valid option to close the loop."
    end
  end
  cohorts
end

#Below method prints students into separate lists depending on their cohort.
#You can filter whom you want to print by firsdt letter of their name, max. name length or cohort.
def print_students_list
  students = filter_ask
  if students == [] then return puts "No students meet your criteria. Sorry." end
  cohorts = cohort_filter(students)
  print_header
  cohorts.each do |cohort|
    puts cohort.to_s.upcase + ":"
    n = 1
    students.each do |student|
      if student[:cohort] == cohort
        puts "#{n}. #{student[:name]} (hobby: #{student[:hobby]}, origin: #{student[:origin]}, pony: #{student[:pony]})"
        n += 1
      end
    end
    if n == 1 then puts "Sorry, no students in this cohort." end
    puts ""
  end
end

#a method for printing all the list, together with header and footer.
def show_students
  if @students != []
    puts "Ok, lets do it!"
    print_students_list
    print_footer
  else puts "No students to print."
  end
end

#A method for printing our interactive menu
def print_menu
  puts "Welcome to student directory. What would you like to do today?
  \n '1' - Input students
  \n '2' - Print student list
  \n '3' - Save students to a file
  \n '4' - Load students from a file
  \n '9' - Exit"
end

#A method for interactive menu selection process
def process(a)
  case a
  when "1"; @students = input_students
  when "2"; show_students
  when "3"; save_students
  when "4"; try_load_students
  when "9"; puts "Bye bye, come again!"
    exit
  else puts "Please enter a number corresponding to your desired action."
  end
end

#An interactive menu to, well, interact with our program :)
def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

#a block to automatically load default student list if none provided by command line
if ARGV.first.nil?
    load_students("./Cartoons_Academy_Students.csv")
end
interactive_menu