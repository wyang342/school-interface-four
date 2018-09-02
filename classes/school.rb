require_relative 'student'
require_relative 'staff'

class School
    attr_reader :name, :students, :staff

    def initialize(name, address = nil)
        @name = name 
        @address = address   
        @students = Student.all
        @staff = Staff.all  
    end   
    
    def list_students
        students.each_with_index { |s , i| puts "#{i + 1}. #{s.name} #{s.school_id}\n" }
    end 

    def find_student_by_id(id)
        students.find { |student| student.school_id == id}
    end 

     def remove_student(id)
        students.delete(find_student_by_id(id))
        save_students
    end 
    
    def add_student(new_student)
        students << Student.new(new_student)
        save_students
    end 

    def save_students
        CSV.open('./data/students.csv', 'wb') do |csv|
            csv << ['name', 'age', 'role', 'school_id', 'password']
            students.each do | student |
                csv << [ student.name, student.age, student.role, student.school_id, student.password ]
            end
        end 
    end
end 

