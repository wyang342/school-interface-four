# School Interface Four

## Release 0: Refactoring / The School Interface Class 

We are going to refactor our ugly runner file by pulling the user interface logic into a new class. Our new class will be a user interface that can be reused for any instance of school. The `SchoolInterface` class will take a `School` object and handle all the interaction between user and school for us. 

Create a new file in our `classes` directory called `interface.py`. 

```Python
# interface.py

class SchoolInterface:
  
    def initialize(school_name):
        self.school = School(school_name) 

```

Now we can start pulling pieces of our UI out of `runner.py`. We'll start with one large method and then break it up bit by bit. Let's take all the UI code and put it in a method called `run`. 

```Python
from classes.school import School

class SchoolInterface:

    def __init__(self, school_name):
      self.school = School(school_name)

    def run(self):
        while True:
            mode = input("\nWhat would you like to do?\nOptions:\n1. List All Students\n2. View Individual Student <student_id>\n3. Add a Student\n4. Remove a Student <student_id>\n5. Quit\n")

            if mode == '1':
                self.school.list_students()
            elif mode == '2':
                student_id = input('Enter student id:')
                student_string = str(self.school.find_student_by_id(student_id))
                print(student_string)
            elif mode == '3':
                student_data = {'role': 'student'}
                student_data['name'] = input('Enter student name:\n')
                student_data['age'] = input('Enter student age: \n')
                student_data['school_id'] = input('Enter student school id: \n')
                student_data['password'] = input('Enter student password: \n')

                self.school.add_student(student_data)
            elif mode == '4':
                student_id = input("Please enter the student's id:\n")
                self.school.delete_student(student_id)
            elif mode == '5':
                break
```

Now in `runner.py` we can create a new instance of our interface, pass it a school name, and then call `.run()` on it. 

```Python
# runner.py 
from classes.interface import SchoolInterface

SchoolInterface('Rigemont High').run()

```
It's important to note that all we've done is reorganize our code. The program should run just as before. Each time we move code during a refactor, we should test it by either running it ourselves or running tests. Since we don't have any tests, make sure you test features each time to make sure nothing is broken. 

Now that we have our interface class, let's see if there is anything in our `run()` method that can be further broken down into its own method. 

The first thing we do every time through our loop is print out a menu. Let's start by pulling that out. 

```Python 
# interface.py 
def menu(self):
    return "\nWhat would you like to do?\nOptions:\n1 list_students\n2 individul Student <student_id>\n3 add_student\n4 remove_student <student_id>\n5 quit\n"
```

And then we call it in `run`. 

```Python
def run(self):
    while True:
        mode = input(self.menu()) 
```

What other parts of `run()` can be broken out into their own methods? Maybe the large chunk of code where we get data to add a new student? What else? 

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

Some things to consider: What happens if the user enters an employee id that doesn't exist? Does the program exit? Do we ask them again? Same with the password. Can we limit the number of attempts? 

How you implement this is up to you. Write pseudo code and break the process down into small steps. 

When you are done you should be able to call `authenticate_user()` at the top of `run`. 

```Python 
# interface.py

def run(self):
    self.authenticate_user()
    # Methods and logic that run the program will follow. 
    #This code should only run if the user is successfully authenticated. 
```