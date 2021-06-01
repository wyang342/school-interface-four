from classes.school import School


class SchoolInterface:

    def __init__(self, school_name):
        self.school = School(school_name)

    def run(self):
        authenticated = self.authenticate_user()

        if not authenticated:
            print("Please enter the valid credentials.")
            print()
            authenticated_2 = self.authenticate_user()
            if not authenticated:
                print("Second attempt failed.")
                return

        while True:
            mode = input(self.menu())

            if mode == '1':
                self.school.list_students()
            elif mode == '2':
                student_id = input('Enter student id:')
                student_string = str(
                    self.school.find_student_by_id(student_id))
                print(student_string)
            elif mode == '3':
                self.mode_3()

            elif mode == '4':
                student_id = input("Please enter the student's id:\n")
                self.school.delete_student(student_id)
            elif mode == '5':
                break

    def menu(self):
        return "\nWhat would you like to do?\nOptions:\n1 list_students\n2 individul Student <student_id>\n3 add_student\n4 remove_student <student_id>\n5 quit\n"

    def mode_3(self):
        student_data = {'role': 'student'}
        student_data['name'] = input('Enter student name:\n')
        student_data['age'] = input('Enter student age: \n')
        student_data['school_id'] = input(
            'Enter student school id: \n')
        student_data['password'] = input('Enter student password: \n')

        self.school.add_student(student_data)

    def authenticate_user(self):
        employee_ids = []
        for staff in self.school.staff:
            employee_ids.append(staff.employee_id)

        print("Welcome to Ridgemont High")
        print("_________________________")
        print("Please enter a valid employee id:")
        id = input("")
        print()

        if (id not in employee_ids):
            return False

        print()
        print("Please enter a valid password:")
        pswrd = input("")

        for staff in self.school.staff:
            if (id == staff.employee_id and pswrd == staff.password):
                return True

        return False
