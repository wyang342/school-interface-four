# School Interface Four

## Release 0: Refactoring / The School Interface Class 

We are going to refactor our ugly runner file by pulling the user interface logic into a new class. Our new class will be a user interface that can be reused for any instance of school. The `SchoolInterface` class will take a `School` object and handle all the interaction between user and school for us. 

Create a new file in our `classes` directory called `interface.rb`. 

```Ruby
# interface.rb

require_relative 'school'

class SchoolInterface
    attr_reader :school 
    
    def initialize(school_name)
        @school = School.new(school_name) 
    end 
end 
```

Now we can start pulling pieces of our UI out of `runner.rb`. We'll start with one large method and then break it up bit by bit. Let's take all the UI code and put it in a method called `run`. 

```Ruby
# interface.rb 
def run 
    # copied from runner.rb
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
end 
```

Now in `runner.rb` we can create a new instance of our interface, pass it a school name, and then call `.run` on it. 

```Ruby
# runner.rb 
require_relative './classes/interface'

SchoolInterface.new('Ridgemont High').run 
```
It's important to note that all we've done is reorganize our code. The program should run just as before. Each time we move code during a refactor, we should test it by either running it ourselves or running tests. Since we don't have any tests, make sure you test features each time to make sure nothing is broken. 

Now that we have our interface class, let's see if there is anything in our `run` method that can be further broken down into its own method. 

The first thing we do everytime through our loop is print out a menu. Let's start by pulling that out. 

```Ruby 
# interface.rb
def print_menu
    puts "\nWhat would you like to do?\nOptions:\n1 list_students\n2 individul Student <student_id>\n3 add_student\n4 remove_student <student_id>\n5 quit\n"
end
```

And then we call it in `run`. 

```Ruby
 def choose_menu_item
        mode = nil 
        until mode == '5'
            print_menu # this is much more readable. Our steps are starting to look like a list of steps in english. 
            mode = gets.chomp
            puts '' 
```

What other parts of `run` can be broken out into their own methods? Maybe the large chunk of code where we get data to add a new student? 

## Release 1: Authentication 

```
Welcome to Ridgemont High
_________________________
Please enter a valid employee id:
11111

Please enter a valid password:
xx
```

Right now anyone can run our program and access student records. Let's add a feature that checks if the user is present in our `staff.csv` file and then uses their password to authenticate the user. What are the steps we'll have to take to accomplish this? 

First, we'll need to ask the user for their employee id. Using that id we can look up the user. After that we'll ask the user for their password which we can compare to the password saved on the object. If they match, we continue to run the program as before. 

Some things to consider. What happens if the user enters an employee id that doesn't exist? Does the program exit? Do we ask them again? Same with the password. Can we limit the number of attempts? 

How you implement this is up to you. Write pseudo code and break the process down into small steps. 

When you are done you should be able to call `authenticate_user` at the top of `run`. 

```Ruby 
# interface.rb 

def run 
    authenticate_user
    # Methods and logic that run the program will follow. 
    #This code should only run if the user is successfully authenticated. 
end 
```