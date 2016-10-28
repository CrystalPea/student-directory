require "date"

#variables needed for methods below to work
$line_width = 60
@students = []

#a method for inputing students and data about the students:
def input_students
  puts "Please enter the names of the students. One name at a time, and then return button."
  puts "To finish, just hit return/enter twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    puts "What cohort are they in?"
    cohort = STDIN.gets.chomp
    if (cohort != nil) && ((Date::MONTHNAMES).include? cohort.capitalize)
      cohort = cohort.downcase.to_sym
    else cohort = :unknown
    end
    puts "What's their hobby?"
    hobby = STDIN.gets.chop
    puts "Where do they come from?"
    origin = STDIN.gets.gsub("\n", "")
    puts "Are they a pony? (yes/no)"
    pony = STDIN.gets.chomp
    if pony.downcase == "yes"
      pony = true
    elsif pony.downcase == "no"
      pony = false
    else puts "I didn't catch that. I will assume that they are not a pony."
      pony = false
    end
    @students << {name: name, cohort: cohort, hobby: hobby, origin: origin, pony: pony}
    puts "Now we have #{@students.count} student#{if (@students.count) > 1 then "s" end}. If you want to add more, write their name. Otherwise just hit return/enter button."
    name = STDIN.gets.chomp
  end
  @students
end

#a method for saving student list to file
def save_students
  puts "How would you like to name your students list?"
  file = File.open("./lists/#{STDIN.gets.chomp}.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:hobby], student[:origin], student[:pony]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

#a method for converting strings to booleans, needed for loading method
def to_boolean(str)
  str == 'true'
end

def load_file
  if ((Dir["./lists/*.csv"]).length) == 0
    puts "Nothing to load sadly."
  else which = nil
    loop do
      puts "Input the path of the file you would like to load ...Or hit return twice to quit"
      puts (Dir["./lists/*.csv"].join("\n"))
      which = STDIN.gets.chomp
      if (Dir["./lists/*.csv"]).include? "#{which}"
        break
      elsif which == ""
        return puts "Ok, back to menu."
      else puts "No file like this. Try again."
      end
    end
  end
  which
end

#a method for trying to load student list file from arguments supplied by command line
def try_load_students
  filename = ARGV.first
  return load_students if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} student#{if (@students.count) > 1 then "s" end} from #{filename}."
  else
    puts "Sorry, no file #{filename} doesn't exist."
    return
  end
end

#a method for loading a student list from a file
def load_students(filename = load_file)
  file = File.open("#{filename}", "r")
  file.readlines.each do |line|
    name, cohort, hobby, origin, pony = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym, hobby: hobby, origin: origin, pony: to_boolean(pony)}
    puts "Loaded #{@students.count} student#{if (@students.count) > 1 then "s" end} from #{filename}."
  end
  file.close
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
    letter = STDIN.gets.chomp
    if letter.length == 1
      @students.each {|student| if (student[:name].downcase.start_with?(letter.downcase)) then filtered << student end}
      return filtered
    elsif letter.length == 0
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
      @students.each {|student| if (student[:name].length < (cc.to_i)) then filtered << student end}
      return filtered
    elsif cc.length == 0
      return @students
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
    puts "Would you like to filter students by first letter of their name or character count?\n'1' - by name\n'2' - by character count\n'3' - both\n'4' - none"
    filter = STDIN.gets.chomp
    case filter
    when "1"
     return students = letter_filter
    when "2"
      return students = cc_filter
    when "3"
      return students = double_filter
    when "4"
      puts "Well noted."
      break
    else puts "Please enter a valid answer"
    end
  end
  students
end

#Below method prints students into separate lists depending on their cohort.
#You can also choose to only see students from your chosen cohorts.
def print_students_list
  students = filter_ask
  return puts "No students meet your criteria. Sorry." if students == [] 
  cohorts = []
  students.each {|student| if !(cohorts.include? student[:cohort]) then cohorts << student[:cohort] end}
  loop do
    puts "Would you like to filter the students you see by cohort?
    \n'1' for yes
    \n'2' for no"
    answer = STDIN.gets.chomp
    if answer == "1"
      puts "Which cohort would you like to print?"
      puts "You can choose from: #{cohorts.join(", ")}"
      filter = STDIN.gets.chomp
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
def show_students
  if @students != []
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
  when "1"
    @students = input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    try_load_students
  when "9"
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

interactive_menu