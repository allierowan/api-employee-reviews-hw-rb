# Employee Reviews DB and API

## Description

Allows the user to keep track of a department's staff, and the details of each employee within a department. Also allows access to the db through an API.

## Features

* Create new departments, each with their own empty "staff" array:
```
marketing = Department.new("Marketing")
```
* Create new employees:
```
new_employee = Employee.new(name, phone, email, salary )
```
* Add employees to a department:
```
marketing.add_employee(employee)
```
* Add text reviews to each employee using:
```
new_employee.add_employee_review(review)
```
* Give raises to an entire department.
* Give raises to specific employees in a department based upon criteria of the user's choosing.
* Scan employee review text and evaluate an employee's performance.
* Access an employees performance rating rating at any time.

## API Features
* Get all employees
```ruby
get "/q/employees"
```
* Get one employee by their ID
```ruby
get "/q/employee?id=15"
```
* Get employees based on different params
```ruby
get "/q/employees_where?name=Allie&email=arowan@gmail.com"
```
* Create an employee
```ruby
post("/p/employee", {name: "Deoch", email: "deoch@theeolian.com"}.to_json)
```
* Delete an employee by their ID
```ruby
delete("/d/employee", {id: 10}.to_json)
```
* Update an employee's name by their ID
```ruby
patch("/u/employee", {id: 10, new_name: "Allie"}.to_json)
```
