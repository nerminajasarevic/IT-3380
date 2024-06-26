import mysql.connector

def get_EmployeesPerCountry(mycursor):

    print("\nView employee count data per country.")

    country = input("Enter the country or ALL for all countries: ")

    if (country.upper() == "ALL"):
        sql_query = "SELECT * FROM EmployeesPerCountry;"
    else: 
        sql_query = f"SELECT * FROM EmployeesPerCountry WHERE country_name = '{country}';"

    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()
    row_count = len(query_result)

    if row_count == 0:

        print("\nNo results found\n")
    else:

        print(f"\nEmployees from {country}")

        for record in query_result:
            print(f"Country Name: {record[0]}, Number of Employees: {record[1]}\n")
    return


def get_managers(mycursor):

    print("\nView manager count by department")

    department = input("Enter the department or ALL for all departments: ")

    if (department.upper() == "ALL"):
        sql_query = "SELECT department_name, COUNT(*) AS 'Number of Managers' FROM managers GROUP BY department_name ORDER BY COUNT(*) DESC;"
    else:
        sql_query = f"SELECT department_name, COUNT(*) AS 'Number of Managers' FROM managers WHERE department_name = '{department}' GROUP BY department_name ORDER BY COUNT(*) DESC;"

    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()
    row_count = len(query_result)

    if row_count == 0:
        
        print("\nNo results found")
    else:

        print(f"\nNumber of Managers from {department}")

        for record in query_result:
            print(f"Department Name: {record[0]}, Number of Managers: {record[1]}\n")
    return


def get_DependentsByJobTitle(mycursor):

    print("\nView dependent data per job title")

    title = input("Enter the job title or ALL for all job titles: ")

    if (title.upper() == "ALL"):
        sql_query = "SELECT job_title, NumberOfDependents FROM DependentsByJobTitle;"
    else:
        sql_query = f"SELECT job_title, NumberOfDependents FROM DependentsByJobTitle WHERE job_title = '{title}';"

    
    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()
    row_count = len(query_result)

    if row_count == 0:

        print("\nNo results found")
    else:

        print(f"\nDependents from {title}")

    for record in query_result:
        print(f"Job Title: {record[0]}, Number of Dependents: {record[1]}\n")
    return


def get_DepartmentHiresByYear(mycursor):

    print("\nView hiring data by year and department")

    department = input("Enter the department or ALL for all departments: ")
    year = input("Enter the year or all for all years: ")

    if (department.upper() == "ALL" and year.upper() == "ALL"):
        sql_query = "SELECT * FROM DepartmentHiresByYear;"
    elif (department.upper() == "ALL"):
        sql_query = f"SELECT * FROM DepartmentHiresByYear WHERE Year = '{year}';"
    elif (year.upper() == "ALL"):
        sql_query = f"SELECT * FROM DepartmentHiresByYear WHERE department_name = '{department}';"
    else:
        sql_query = f"SELECT * FROM DepartmentHiresByYear WHERE Year = '{year}' AND department_name = '{department}' GROUP BY Year;"

    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()
    row_count = len(query_result)

    if row_count == 0:

        print("\nNo results found")
    else:
        print("\nDepartment Hires")

    for record in query_result:
        print(f"Year: {record[0]}, Department Name: {record[1]}, Employees Hired: {record[2]}\n")
    return


def get_AvgSalaryByJobTitle(mycursor):

    print("\nView average Salary data by job title")
    
    title = input("Enter the job title or ALL for all job titles: ")

    if (title.upper() == "ALL"):
        sql_query = "SELECT * FROM AvgSalaryByJobTitle;"
    else:
        sql_query = f"SELECT * FROM AvgSalaryByJobTitle WHERE job_title = '{title}';"


    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()
    row_count = len(query_result)

    if row_count == 0:

        print("\nNo results found")
    else:
        print(f"\nAverage Salary for {title}")

    for record in query_result:
        print(f"Job Title: {record[0]}, Average Salary: {record[1]}, Number of Employees: {record[2]}\n")
    return


def get_AvgSalaryByDepartment(mycursor):

    print("\nView salary Salary data by department")

    department = input("Enter departement or ALL for all departments: ")

    if (department.upper() == "ALL"):
        sql_query = f"SELECT * FROM AvgSalaryByDepartment;"
    else:
        sql_query = f"SELECT * FROM AvgSalaryByDepartment WHERE department_name = '{department}';"
    
    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()
    row_count = len(query_result)

    if row_count == 0:

        print("\nNo results found")
    else:
        print(f"\nAverage Salary from {department}")

    for record in query_result:
        print(f"Department Name: {record[0]}, Average Salary: {record[1]}, Number of Employees: {record[2]}\n")
    return


def get_EmployeeDependents(mycursor):

    print("\nView dependent data by employee")

    employee = input("Enter employee id or ALL for all employees: ")

    if (employee.upper() == "ALL"):
        sql_query = "SELECT * FROM EmployeeDependents;"
    else:
        sql_query = f"SELECT * FROM EmployeeDependents WHERE employee_id = '{employee}';"

    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()
    row_count = len(query_result)

    if row_count == 0:

        print("\nNo results found")
    else:
        print(f"\nDependents from employee {employee}")

    for record in query_result:
        print(f"Name: {record[0]} {record[1]}, Email: {record[2]}, Phone Number: {record[3]}, Number of Dependents: {record[4]}\n")
    return


def get_CountryLocation(mycursor):

    print("\nView location data by region")

    region = input("Enter the region or ALL for all regions: ")

    if(region.upper() == "ALL"):
        sql_query = "SELECT * FROM CountryLocation;"
    else:
        sql_query = f"SELECT * FROM CountryLocation WHERE region_name = '{region}';"

    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()
    row_count = len(query_result)

    if row_count == 0:

        print("\nNo results found")
    else:
        print(f"\nLocations for {region}")

    for record in query_result:
        print(f"Region Name: {record[0]}, Number of Locations: {record[1]}\n")
    return 


def add_Dependent(mycursor):

    print("\n--ADD DEPENDENT--")

    first = input("Enter the first name of the dependent: ")
    last = input("Enter the last name of the dependent: ")
    relationship = input("Enter the relationship to the employee: ")
    id = input("Enter the employee id: ")

    sql_query = f"INSERT INTO dependents(first_name,last_name,relationship,employee_id) VALUES ('{first}','{last}','{relationship}',{id});"

    mycursor.execute(sql_query)

    if mycursor.rowcount == 0:
        print("\nFailed to add dependent.")
    else:
        print("\nDependent has been added.")

    return

def add_Job(mycursor):

    print("\n--ADD JOB--")

    job = input("Enter the job title: ")
    min = input("Enter the min salary: ")
    max = input("Enter the max salary: ")

    sql_query = f"INSERT INTO jobs(job_title,min_salary,max_salary) VALUES ('{job}','{min}','{max}';)"

    mycursor.execute(sql_query)

    if mycursor.rowcount == 0:
        print("\nFailed to add job.")
    else:
        print("\nJob has been added.")

    return

def delete_Employee(mycursor):

    print("\n--DELETE EMPLOYEE--")

    id = input("Enter the id of the employee to be deleted: ")
    
    sql_query = f"DELETE FROM employees WHERE employee_id = '{id}';"

    mycursor.execute(sql_query)

    if mycursor.rowcount > 0:
        print("\nThe employee has been deleted.")
    else:
        print("\nFailed to delete employee.")

    return

def delete_Dependent(mycursor):

    print("\n--DELETE DEPENDENT--")

    id = input("Enter the id of the dependent to be deleted: ")
    
    sql_query = f"DELETE FROM dependents WHERE dependent_id = '{id}';"

    mycursor.execute(sql_query)

    if mycursor.rowcount > 0:
        print("\nThe dependent has been deleted.")
    else:
        print("\nFailed to delete dependent.")

    return

def update_First(mycursor):

    print("\n--UPDATE FIRST NAME--")

    id = input("Enter the employee id: ")
    name = input("Enter the first name: ")

    sql_query = f"UPDATE employees SET first_name = '{name}' WHERE employee_id = '{id}';"

    mycursor.execute(sql_query)

    if mycursor.rowcount > 0:
        print("\nFirst name has been updated.")
    else:
        print("\nFailed to update first name.")

    return

def update_Last(mycursor):

    print("\n--UPDATE LAST NAME--")

    id = input("Enter the employee id: ")
    name = input("Enter the last name: ")

    sql_query = f"UPDATE employees SET last_name = '{name}' WHERE employee_id = '{id}';"

    mycursor.execute(sql_query)

    if mycursor.rowcount > 0:
        print("\nLast name has been updated.")
    else:
        print("\nFailed to update last name.")

    return

def update_Min(mycursor):

    print("\n--UPDATE MINIMUM SALARY--")

    id = input("Enter the job id: ")
    min = input("Enter the min salary: ")

    sql_query = f"UPDATE jobs SET min_salary = '{min}' WHERE job_id = '{id}';"

    mycursor.execute(sql_query)

    if mycursor.rowcount > 0:
        print("\nMin salary has been updated.")
    else:
        print("\nFailed to update min salary")

    return

def update_Max(mycursor):

    print("\n--UPDATE MAXIMUM SALARY--")

    id = input("Enter the job id: ")
    max = input("Enter the max salary: ")

    sql_query = f"UPDATE jobs SET max_salary = '{max}' WHERE job_id = '{id}';"

    mycursor.execute(sql_query)

    if mycursor.rowcount > 0:
        print("\nMax salary has been updated.")
    else:
        print("\nFailed to update max salary.")

    return

def print_menu():
    print("Choose an option. ")

    print("--VIEW DATA--")
    print("1. Show Number of Employees per Country")
    print("2. Show Number of Managers per Deparment")
    print("3. Show Number of Dependents per Job Title")
    print("4. Show Deparment Hires per Year and Department")
    print("5. Show Average Salary per Job Title")
    print("6. Show Salary per Department")
    print("7. Show Dependents by Employee")
    print("8. Show Locations per Region")

    print("--ADD DATA--")
    print("9. Add a dependent")
    print("10. Add a job")

    print("--DELETE DATA--")
    print("11. Delete an employee")
    print("12. Delete a dependent")

    print("--UPDATE DATA--")
    print("13. Update employee's first name")
    print("14. Update employee's last name")
    print("15. Update minimum salary")
    print("16. Update maximum salary")

    print("--EXIT--")
    print("17. Exit Application")
    return


def get_user_choice():
    print_menu()

    while True:
        try:
            choice = int(input("Enter choice: "))
        except ValueError:
            print("Please enter a valid integer 1-17.")
            continue
        if choice >= 1 and choice <= 17:
            print(f'You entered: {choice}')
            break
        else:
            print('Please enter an integer 1-17.')
    
    return choice

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
            add_Dependent(mycursor)
        elif user_choice == 10:
            add_Job(mycursor)
        elif user_choice == 11:
            delete_Employee(mycursor)
        elif user_choice == 12:
            delete_Dependent(mycursor)
        elif user_choice == 13:
            update_First(mycursor)
        elif user_choice == 14:
            update_Last(mycursor)
        elif user_choice == 15:
            update_Min(mycursor)
        elif user_choice == 16:
            update_Max(mycursor)
        elif user_choice == 17:
            print("Exiting Program...")
            break

main()