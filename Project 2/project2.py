import mysql.connector

def print_menu():
    print("Choose an option 1-9")
    print("1. Show Employees in the UK")
    print("2. Show Number of Managers per Deparment")
    print("3. Show Job Titles with the Most Dependents")
    print("4. Show Deparment Hires from 1998")
    print("5. Show Average Salary for Programmers")
    print("6. Show Deparment with the Lowest Average Salary")
    print("7. Show Employees with no Dependents")
    print("8. Show Regions with no Locations")
    print("9. Exit Application")
    return


def get_user_choice():
    print_menu()
    choice = 0

    while True:
        try:
            choice = int(input("Enter an integer 1-9: "))
        except ValueError:
            print("Please enter a valid integer 1-9")
            continue
        if choice >= 1 and choice <= 9:
            print(f'You entered: {choice}')
            break
        else:
            print('Please enter a valid integer 1-9')
    
    return choice

# 1
def get_EmployeesPerCountry(mycursor):
    sql_query = "SELECT * FROM EmployeesPerCountry WHERE country_name = 'United Kingdom';"

    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()
    row_count = len(query_result)

    if row_count == 0:

        print("\nNo employees found from the United Kingdom.\n")
    else:

        print("\nEmployees from the United Kingdom")

        for record in query_result:
            print(f"Country Name: {record[0]}, Number of Employees: {record[1]}\n")
    return

# 2
def get_managers(mycursor):
    sql_query = "SELECT department_name, COUNT(*) AS 'Number of Managers' FROM managers GROUP BY department_name ORDER BY COUNT(*) DESC;"

    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()

    print("\nNumber of Managers Per Department")

    for record in query_result:
        print(f"Department Name: {record[0]}, Number of Managers: {record[1]}\n")
    return

# 3
def get_DependentsByJobTitle(mycursor):
    sql_query = "SELECT * FROM DependentsByJobTitle WHERE NumberOfDependents = (SELECT MAX(NumberOfDependents) FROM DependentsByJobTitle);"
    
    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()

    print("\nJob Titles with the most dependents")

    for record in query_result:
        print(f"Job Title: {record[0]}, Number of Dependents: {record[1]}\n")
    return

# 4
def get_DepartmentHiresByYear(mycursor):
    sql_query = "SELECT * FROM DepartmentHiresByYear WHERE Year = 1998;"

    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()

    print("\nDepartment Hires in 1998")

    for record in query_result:
        print(f"Year: {record[0]}, Department Name: {record[1]}, Employees Hired: {record[2]}\n")
    return

# 5
def get_AvgSalaryByJobTitle(mycursor):
    sql_query = "SELECT * FROM AvgSalaryByJobTitle WHERE job_title = 'Programmer';"

    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()

    print("\nAverage Salary for Programmers")

    for record in query_result:
        print(f"Job Title: {record[0]}, Average Salary: {record[1]}, Number of Employees: {record[2]}\n")
    return

# 6
def get_AvgSalaryByDepartment(mycursor):
    sql_query = "SELECT * FROM AvgSalaryByDepartment WHERE AverageSalary = (SELECT MIN(AverageSalary) FROM AvgSalaryByDepartment);"
    
    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()

    print("\nDepartment with the Lowest Average Salary")

    for record in query_result:
        print(f"Department Name: {record[0]}, Average Salary: {record[1]}, Number of Employees: {record[2]}\n")
    return

# 7
def get_EmployeeDependents(mycursor):
    sql_query = "SELECT * FROM EmployeeDependents WHERE NumberOfDependents = 0;"

    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()

    print("\nEmployees with no Dependents")

    for record in query_result:
        print(f"Name: {record[0]} {record[1]}, Email: {record[2]}, Phone Number: {record[3]}, Number of Dependents: {record[4]}\n")
    return

# 8
def get_CountryLocation(mycursor):
    sql_query = "SELECT * FROM CountryLocation WHERE NumberOfLocations = 0;"

    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()

    print("\nRegions with no locations")

    for record in query_result:
        print(f"Region Name: {record[0]}, Number of Locations: {record[1]}\n")
    return 

def main():
    
    try:
        mydb = mysql.connector.connect(
            host="mysql-container",
            user="root",
            passwd="root",
            database="project2"
        )
        print("Successfully connected to the database!")

    except Exception as err:
        print(f"Error Occured: {err}\nExiting program...")
        quit()

    mycursor = mydb.cursor()
    
    while True:
        user_choice = get_user_choice()

        if user_choice == 1:
            get_EmployeesPerCountry(mycursor)
        elif user_choice == 2:
            get_managers(mycursor)
        elif user_choice == 3:
            get_DependentsByJobTitle(mycursor)
        elif user_choice == 4:
            get_DepartmentHiresByYear(mycursor)
        elif user_choice == 5:
            get_AvgSalaryByJobTitle(mycursor)
        elif user_choice == 6:
            get_AvgSalaryByDepartment(mycursor)
        elif user_choice == 7:
            get_EmployeeDependents(mycursor)
        elif user_choice == 8:
            get_CountryLocation(mycursor)
        elif user_choice == 9:
            print("Exiting Program...")
            break

main()