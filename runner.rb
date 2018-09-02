require_relative './classes/school.rb' 

school = School.new('Ridgemont High', '1212 Main st.')

mode = nil 
until mode == '5'
    puts "\nWhat would you like to do?\nOptions:\n1 list_students\n2 individul Student <student_id>\n3 add_student\n4 remove_student <student_id>\n5 quit\n"

    mode = gets.chomp
    puts '' 
    case mode 
    when '1'
        school.list_students
    when '2'
        puts 'Enter student id:'
        puts school.find_student_by_id(gets.chomp)          
    when '3'
        new_student = {role: 'Student'}

        puts "Enter name:\n"
        new_student[:name] = gets.chomp 
        puts "Enter age:\n"
        new_student[:age] = gets.chomp 
        puts "Enter school_id:\n"
        new_student[:school_id] = gets.chomp 
        puts "Enter password:\n"
        new_student[:password] = gets.chomp 

        school.add_student(new_student)
    when '4'
        puts 'Enter Student id:'
        school.remove_student(gets.chomp)
    when '5' 
        return 
    end  
end 